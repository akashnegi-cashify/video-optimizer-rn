---
name: ApiLogger one-go migration
overview: Create a reusable, idempotent Cursor-executable migration that adds Android+iOS apiLogger from the `react-lego-buy` submodule into host RN apps in one run.
todos:
  - id: define-runner-contract
    content: Define migration runner inputs, assumptions, and idempotency rules for multi-project reuse
    status: completed
  - id: android-apiLogger-automation
    content: Automate Android file copy + MainApplication patching (package registration + OkHttp interceptor wiring)
    status: completed
  - id: ios-apiLogger-automation
    content: Automate iOS file copy + AppDelegate session protocol registration
    status: completed
  - id: verification-steps
    content: Add compile/runtime verification checklist and duplicate-protection checks
    status: completed
  - id: fix-map-consumed-bug
    content: Fix "Map already consumed" crash — store logs as HashMap snapshots, not WritableMap
    status: completed
  - id: enable-logging-wiring
    content: Call enableLogging() on native module from App.tsx so logs are actually captured
    status: completed
  - id: header-debug-icon
    content: Auto-inject debug icon into Header component on stage/beta builds
    status: completed
  - id: js-screen-full-detail
    content: ApiLoggerScreen — show request/response headers + body + share functionality
    status: completed
isProject: false
---

# ApiLogger One-Go Migration Plan

## Goal

Build a reusable migration flow that can be executed in Cursor to auto-integrate `apiLogger` for both Android and iOS in this project and future projects that include `react-lego-buy` as a submodule.

## Source-of-truth modules

- Android source folder: `react-lego-buy/android/app/src/main/java/in/lego/app/module/apiLogger/`
- iOS source folder: `react-lego-buy/ios/LegoApp/module/ApiLogger/`

---

## Step 1 — Migration runner (idempotent)

Create a single migration entrypoint that:
- Detects project root and validates submodule presence.
- Verifies required target files exist before patching.
- Skips already-integrated blocks safely (idempotent — safe to re-run).

---

## Step 2 — Android integration

### 2a. Copy Kotlin files

Copy all 6 files from the submodule into the host app package:

```
<submodule>/android/app/src/main/java/in/lego/app/module/apiLogger/
  LegoAPILoggerInterceptor.kt
  LegoAPILoggerModule.kt
  LegoAPILoggerPackage.kt
  LegoAPILoggerStore.kt
  LegoTimingEventListener.kt
  RequestTimingStore.kt
```

Destination: `android/app/src/main/kotlin/<host_package>/module/apiLogger/`

Update the `package` declaration at the top of each file to match the host package (e.g. `package in.cashify.supersale.module.apiLogger`).

### 2b. Patch MainApplication.kt

Add imports (skip if already present):
```kotlin
import <host_package>.module.apiLogger.LegoAPILoggerInterceptor
import <host_package>.module.apiLogger.LegoAPILoggerPackage
import <host_package>.module.apiLogger.LegoTimingEventListener
import com.facebook.react.modules.network.OkHttpClientProvider
```

Add `LegoAPILoggerPackage()` inside `PackageList(...).packages.apply { ... }`:
```kotlin
PackageList(this).packages.apply {
    add(FlutterBridgePackage())
    add(LegoAPILoggerPackage())   // ← add this
}
```

Add `initHttpClient()` method and call it from `onCreate()` **before** `loadReactNative(this)`:
```kotlin
override fun onCreate() {
    super.onCreate()
    initHttpClient()   // ← must be before loadReactNative
    loadReactNative(this)
}

private fun initHttpClient() {
    val builder = OkHttpClientProvider.createClientBuilder(this)
    builder.addInterceptor(LegoAPILoggerInterceptor())
    builder.eventListenerFactory(LegoTimingEventListener.Factory())
    val okHttpClient = builder.build()
    OkHttpClientProvider.setOkHttpClientFactory { okHttpClient }
}
```

> **Why before loadReactNative**: `OkHttpClientProvider.setOkHttpClientFactory` must be called before any OkHttp client is created. If called after `loadReactNative`, the factory is ignored.

### 2c. CRITICAL — Fix "Map already consumed" in LegoAPILoggerStore.kt

**This is a mandatory fix.** The copied `LegoAPILoggerStore.kt` from the submodule stores `WritableMap` objects directly. When `addLog` emits the map via `eventEmitter`, the bridge **consumes** the `WritableMap`, making it unusable. A later call to `getLogs()` tries to `pushMap` the same consumed object and throws `Exception in HostFunction: Map already consumed`.

**Fix**: Store logs as `HashMap<String, Any?>` snapshots and reconstruct fresh `WritableMap`s in `getLogs()`.

Replace the `logs` field and `addLog` / `getLogs` in `LegoAPILoggerStore.kt`:

```kotlin
// BEFORE (broken):
private val logs = mutableListOf<WritableMap>()

fun addLog(log: WritableMap) {
    logs.add(log)
    eventEmitter?.invoke(log)   // ← consumes log; getLogs() will crash
}

fun getLogs(): WritableArray {
    return Arguments.createArray().apply {
        logs.forEach { log -> pushMap(log) }   // ← Map already consumed crash
    }
}
```

```kotlin
// AFTER (correct):
private val logs = mutableListOf<HashMap<String, Any?>>()

fun addLog(log: WritableMap) {
    val snapshot = log.toHashMap()   // snapshot BEFORE bridge consumes it
    logs.add(snapshot)
    eventEmitter?.invoke(log)        // bridge may consume log here — snapshot is safe
}

fun getLogs(): WritableArray {
    return Arguments.createArray().apply {
        logs.forEach { snapshot -> pushMap(toWritableMap(snapshot)) }
    }
}

@Suppress("UNCHECKED_CAST")
private fun toWritableMap(map: Map<String, Any?>): WritableMap {
    return Arguments.createMap().also { out ->
        map.forEach { (key, value) ->
            when (value) {
                null -> out.putNull(key)
                is Boolean -> out.putBoolean(key, value)
                is Int -> out.putInt(key, value)
                is Long -> out.putDouble(key, value.toDouble())
                is Float -> out.putDouble(key, value.toDouble())
                is Double -> out.putDouble(key, value)
                is String -> out.putString(key, value)
                is Map<*, *> -> out.putMap(key, toWritableMap(value as Map<String, Any?>))
                is List<*> -> out.putArray(key, toWritableArray(value))
                else -> out.putString(key, value.toString())
            }
        }
    }
}

@Suppress("UNCHECKED_CAST")
private fun toWritableArray(list: List<*>): WritableArray {
    return Arguments.createArray().also { out ->
        list.forEach { item ->
            when (item) {
                null -> out.pushNull()
                is Boolean -> out.pushBoolean(item)
                is Int -> out.pushInt(item)
                is Long -> out.pushDouble(item.toDouble())
                is Float -> out.pushDouble(item.toDouble())
                is Double -> out.pushDouble(item)
                is String -> out.pushString(item)
                is Map<*, *> -> out.pushMap(toWritableMap(item as Map<String, Any?>))
                is List<*> -> out.pushArray(toWritableArray(item))
                else -> out.pushString(item.toString())
            }
        }
    }
}
```

---

## Step 3 — iOS integration

### 3a. Copy Swift/ObjC files

Copy all 4 files from the submodule:
```
<submodule>/ios/LegoApp/module/ApiLogger/
  LegoAPILoggerModule.swift
  LegoAPILoggerModule.m
  LegoAPILoggerStore.swift
  LegoAPILoggerProtocol.swift
```

Destination: `ios/<TargetName>/` (the folder containing `AppDelegate.swift`).

### 3b. Add files to Xcode project

**Copying files to the folder is not enough.** They must be added to the Xcode build target's Compile Sources phase. Add all 4 files to the `.xcodeproj/project.pbxproj` — either via Xcode UI (File → Add Files) or by scripting the pbxproj entries.

### 3c. Patch AppDelegate.swift

Add `RCTSetCustomNSURLSessionConfigurationProvider` call and `customSessionConfiguration()` method inside `application(_:didFinishLaunchingWithOptions:)`, **before** `factory.startReactNative(...)`:

```swift
RCTSetCustomNSURLSessionConfigurationProvider { [weak self] in
    self?.customSessionConfiguration() ?? URLSessionConfiguration.default
}
```

Add the helper method to `AppDelegate`:
```swift
private func customSessionConfiguration() -> URLSessionConfiguration {
    let configuration = URLSessionConfiguration.default
    var protocolClasses = configuration.protocolClasses ?? []
    protocolClasses.insert(LegoAPILoggerProtocol.self, at: 0)
    configuration.protocolClasses = protocolClasses
    return configuration
}
```

> **Why before startReactNative**: The custom session provider must be registered before the React Native bridge initializes its networking layer.

---

## Step 4 — JS wiring

### 4a. Environment flag

Add `ENABLE_API_LOGGER` to env files:
```
env/.env.stage  → ENABLE_API_LOGGER=true
env/.env.beta   → ENABLE_API_LOGGER=true
env/.env.prod   → ENABLE_API_LOGGER=false
```

### 4b. App.tsx — enable logging on startup

Inside the `isApiLoggerEnabledFromEnv()` block in `App.tsx` (or equivalent app entry), call `enableLogging()` on the native module.

**This is mandatory.** `LegoAPILoggerStore.loggingEnabled` defaults to `false`. The OkHttp interceptor (Android) and `URLProtocol` (iOS) both gate on this flag — without calling `enableLogging()`, zero requests are captured even though the interceptor is wired.

```typescript
import Config from 'react-native-config';
import { NativeModules } from 'react-native';

function isApiLoggerEnabledFromEnv(): boolean {
    const raw = (Config as { ENABLE_API_LOGGER?: string }).ENABLE_API_LOGGER;
    if (!raw) return false;
    return raw.trim().toLowerCase() === 'true';
}

// In useEffect on app init:
if (isApiLoggerEnabledFromEnv()) {
    startNetworkLogging();
    setDevModeEnabled(true).catch(() => {});
    setApiLoggerEnabled(true).catch(() => {});
    NativeModules.LegoAPILoggerModule?.enableLogging();   // ← REQUIRED, do not omit
}
```

### 4c. Route registration

Add the `API_LOGGER` route in `src/navigation/routes.ts`:
```typescript
export const Routes = {
    // ...existing routes
    API_LOGGER: '/api-logger',
} as const;

export type RootStackParamList = {
    // ...
    [Routes.API_LOGGER]: undefined;
};
```

Register the screen in the navigator:
```tsx
<Stack.Screen name={Routes.API_LOGGER} component={ApiLoggerScreen} />
```

### 4d. Header — auto debug icon

Patch the host app's `Header` component to automatically show a tappable debug icon on stage/beta builds. This gives access to the logger from any screen without per-screen changes.

In `src/components/common/Header.tsx`:

```typescript
import { useNavigation } from '@react-navigation/native';
import Config from 'react-native-config';
import { Routes } from '../../navigation/routes';

const isApiLoggerEnabled =
    (Config as { ENABLE_API_LOGGER?: string }).ENABLE_API_LOGGER?.trim().toLowerCase() === 'true';
```

Inside the component:
```tsx
const navigation = useNavigation<any>();

const debugIcon = isApiLoggerEnabled ? (
    <Pressable onPress={() => navigation.navigate(Routes.API_LOGGER)} hitSlop={12} style={styles.debugBtn}>
        <Text style={styles.debugLabel}>ⓘ</Text>
    </Pressable>
) : null;

// Compose with existing rightContent:
const trailingContent =
    debugIcon != null ? (
        <View style={styles.trailingRow}>
            {rightContent}
            {debugIcon}
        </View>
    ) : rightContent;
```

Replace `rightContent` with `trailingContent` in the JSX return.

Styles to add:
```typescript
trailingRow: { flexDirection: 'row', alignItems: 'center', gap: 4 },
debugBtn: { paddingHorizontal: 8, paddingVertical: 4, justifyContent: 'center', alignItems: 'center' },
debugLabel: { fontSize: 20, color: AppColors.primary, opacity: 0.7 },
```

### 4e. ApiLoggerScreen

Create `src/components/api-logger/ApiLoggerScreen.tsx`. Key requirements:

- Use the host app's `Header` component (not a custom header `View`) for consistent spacing.
- Parse ALL fields the native module provides: `method`, `url`, `status`, `dataSent` (request body), `requestHeaders`, `response` (response body), `responseHeaders`, `responseContentType`, `gqlOperation`, `startTime`, `endTime`.
- **Display in detail view**: URL, status badge (green/red), duration, GQL operation name, REQUEST HEADERS section, REQUEST BODY section (pretty-printed JSON), RESPONSE HEADERS section, RESPONSE BODY section (pretty-printed JSON).
- **Share button**: In the detail view header's `rightContent`, add a "Share" button that calls `Share.share({ message: buildShareText(log) })` with a formatted plain-text dump of all sections.
- **Real-time updates**: Subscribe to `onAPILog` native event via `NativeEventEmitter` so new requests appear without refreshing.
- **Guard**: Check `NativeModules.LegoAPILoggerModule` exists before calling any method; show an error message if the native module is unavailable.

Share text format:
```
[POST] https://api.example.com/endpoint
Status: 200 | 234ms
GQL Operation: GetCart   (if applicable)

── REQUEST HEADERS ──────────────
Content-Type: application/json
Authorization: Bearer ...

── REQUEST BODY ─────────────────
{
  "key": "value"
}

── RESPONSE HEADERS ─────────────
Content-Type: application/json

── RESPONSE BODY ────────────────
{
  "result": "ok"
}
```

---

## Step 5 — Validation checklist

### Android
- [ ] `initHttpClient()` is called **before** `loadReactNative(this)` in `onCreate()`
- [ ] `LegoAPILoggerPackage()` is in the packages list
- [ ] `LegoAPILoggerStore.kt` uses `HashMap` storage (not `WritableMap`) — see Step 2c
- [ ] App compiles without Kotlin errors

### iOS
- [ ] All 4 files are in the Xcode build target's Compile Sources (not just in the folder)
- [ ] `RCTSetCustomNSURLSessionConfigurationProvider` is called before `startReactNative`
- [ ] App compiles without Swift errors

### JS / runtime
- [ ] `ENABLE_API_LOGGER=true` is in stage/beta env files
- [ ] `NativeModules.LegoAPILoggerModule?.enableLogging()` is called on app init
- [ ] `Routes.API_LOGGER` is registered in navigator
- [ ] Tapping the `ⓘ` icon in any Header opens the logger screen
- [ ] Making a network request causes a new row to appear in real time
- [ ] Tapping a row shows headers + body in the detail view
- [ ] "Share" produces correctly formatted text with all sections

---

## Migration preconditions (contract)

Before running this migration on a new project, verify:

1. The project has `react-lego-buy` as a local submodule with the `apiLogger` source folders present.
2. Android: `MainApplication.kt` exists with a `PackageList(...).packages.apply { }` block and `loadReactNative(this)` call.
3. iOS: `AppDelegate.swift` uses a Swift `RCTReactNativeFactory` / `startReactNative(...)` pattern.
4. The host app has a `Header` component at `src/components/common/Header.tsx` with a `rightContent` prop.
5. `react-native-config` is installed and env files are under `env/`.
6. `@react-navigation/native` is installed (needed for `useNavigation` in Header).

---

## Execution outcome

After one run, the project gets:
- Android+iOS apiLogger wired end-to-end with idempotent patches
- Real-time network log capture visible from any screen via the `ⓘ` Header icon (stage/beta only)
- Full request/response detail view with headers, body, timing, and share functionality
- Zero production overhead (`ENABLE_API_LOGGER=false` disables everything at the env level)
