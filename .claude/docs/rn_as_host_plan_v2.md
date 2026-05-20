# Cashify-OPS: RN Host + Flutter Guest Migration — Phase 1

## Context

The current app (`flutter_trc`, displayed as **Cashify-OPS**, codename **COPS**) is a pure Flutter app with 1770 Dart files across 3 flavors (prod/beta/stage). We are migrating to a **React Native host shell + Flutter add-to-app module** architecture so that future feature work can move to React Native incrementally without a one-shot rewrite.

**Phase 1 scope:** RN is a thin shell that, on launch, immediately presents the full Flutter UI. **Zero user-visible behavior changes.** All existing flavors, package IDs, signing, MethodChannels, and plugin functionality continue to work. Existing installs must upgrade in place (same `applicationId` and iOS bundle IDs).

**Success criteria:**
- All 3 flavors install over existing builds without uninstall (Android `in.cashify.androidtrc*`, iOS `in.cashify.iostrc*`).
- App launches into Flutter UI within ~1 frame of native launch (no double splash).
- All 3 project-specific MethodChannels (`compressVideo`, `userauthdetails`, `registerLogout`) work identically.
- `String.fromEnvironment('env')` is replaced by a runtime MethodChannel that resolves correctly per flavor.
- Firebase (Analytics, Crashlytics, Remote Config), `image_picker`, `video_compress`, `ml_barcode_scanner`, `local_auth`, `flutter_tts`, Montserrat fonts all behave as before.
- Jenkins build flow continues to produce signed prod/beta/stage artifacts.

**Out of scope (decided):** WebEngage, deep links, push notifications, jailbreak detection, `flutter_downloader` replacement, `@reglobe/lego-*` npm deps, dynamic links, double-splash fix, custom `staging` build type.

**Reference plan (do NOT copy verbatim):** [.claude/docs/rn_host_flutter_guest_migration_59e530d9.plan.md](.claude/docs/rn_host_flutter_guest_migration_59e530d9.plan.md) — written for SuperSale; many phases here are slimmed or dropped.

> **📌 If you are reusing this plan for a different Flutter → RN migration: READ [Phase 9 — Lessons from Execution](#phase-9--lessons-from-execution-read-this-first-on-a-future-migration) FIRST.** It documents 11 non-obvious gotchas (AGP 8 plugin manifest issues, cached-engine + ActivityAware plugin NPEs, AppCompat theme requirements, Maven path resolution, hot-reload AAR variants, etc.) that the original Phase 1–8 plan didn't anticipate. They WILL bite you again on any project with old Flutter plugins.

---

## Repo Layout (Single Repo, Module Subfolder)

```
flutter_trc/                                   # repo root (existing git repo, kept)
  package.json                                 # NEW — RN 0.83.x
  app.json, index.js, metro.config.js, tsconfig.json, babel.config.js
  react-native.config.js                       # NEW — font asset linking
  .yarnrc.yml                                  # nodeLinker: node-modules
  src/                                         # NEW — RN TypeScript
    App.tsx                                    # thin shell — launches Flutter
    native/CopsFlutterModule.ts                # JS wrapper
    assets/fonts -> ../../flutter_module/assets/fonts   # symlink
  android/                                     # REWRITTEN — RN-host Android
  ios/                                         # REWRITTEN — RN-host iOS (single target + schemes)
  flutter_module/                              # MOVED FROM repo root
    lib/, test/, assets/, l10n.yaml, analysis_options.yaml, pubspec.yaml
    .android/, .ios/                           # auto-generated, gitignored
  android_flutter_backup/                      # current android/ moved here for reference
  ios_flutter_backup/                          # current ios/ moved here for reference
  scripts/                                     # new RN+Flutter build scripts
  docs/DEVELOPER_WORKFLOW.md
```

The current `android/` and `ios/` directories are **moved aside** (renamed `*_flutter_backup/`) so that copied assets / Kotlin / Swift can be referenced during the migration and deleted after Phase 8 passes.

---

## Identity Reference (USE THESE EVERYWHERE)

| Property | Value |
|---|---|
| Codename | **COPS** |
| Android applicationId (prod / beta / stage) | `in.cashify.androidtrc` / `.beta` / `.stage` |
| iOS bundle ID (prod / beta / stage) | `in.cashify.iostrc` / `.beta` / `.stage` |
| Android app name | `Cashify-OPS` / `Cashify-OPS Beta` / `Cashify-OPS Stage` |
| iOS display name | `Cashify Ops` / `Cashify Ops Beta` / `Cashify Ops Stage` |
| MethodChannel namespace | `in.cashify.trc/plugin` |
| Cached engine id | `cops_engine` |
| Flavor dimension (Android) | `tier` |
| Build types (Android) | `debug`, `release` (NO staging — dropped) |
| Custom font | Montserrat (3 weights: 400, 600, 700) |
| Native launch background color | `#0080F0` (current `consoleThemePrimary`) |

---

## Phase 1 — RN Project Initialization

- Install Node 20 LTS; enable Corepack; activate Yarn 4.6.0.
- Run `npx @react-native-community/cli@latest init CashifyOps --version 0.83.1 --pm yarn --directory ../rn_temp`.
- Copy RN config files into repo root: `package.json`, `metro.config.js`, `tsconfig.json`, `babel.config.js`, `app.json`, `react-native.config.js`, `Gemfile`, `index.js`, `.watchmanconfig`.
- Set `app.json` `displayName = "Cashify-OPS"` (will be overridden per-flavor by native strings/Info.plist).
- Copy `rn_temp/android/` and `rn_temp/ios/` into repo (after moving current `android/` -> `android_flutter_backup/` and `ios/` -> `ios_flutter_backup/`).
- Delete `rn_temp/`.
- Create `.yarnrc.yml` with `nodeLinker: node-modules`, `enableImmutableInstalls: false`. **Skip** the SuperSale `npmScopes` block — no `@reglobe/lego-*` deps used here.
- Run `yarn install`.
- Verify RN 0.83 defaults: `newArchEnabled=true`, `hermesEnabled=true`, `minSdkVersion=24`, `compileSdkVersion=36`, `kotlinVersion=2.1.20` (will override to 2.0.0 in Phase 3 to match existing).

---

## Phase 2 — Convert Flutter App to Module

- Run `flutter create --template module flutter_module` (creates the wrapper).
- Move all Dart code into `flutter_module/`:
  - `lib/` → `flutter_module/lib/`
  - `test/` → `flutter_module/test/`
  - `assets/` → `flutter_module/assets/`
  - `pubspec.yaml`, `pubspec.lock`, `analysis_options.yaml`, `l10n.yaml`, `dart_test.yaml`, `devtools_options.yaml` → `flutter_module/`
- Edit `flutter_module/pubspec.yaml`: add module descriptor under `flutter:`:
  ```yaml
  flutter:
    module:
      androidX: true
      androidPackage: in.cashify.androidtrc
      iosBundleIdentifier: in.cashify.iostrc
  ```
  Keep all existing dependencies, dependency_overrides, fonts, and asset declarations exactly as today.
- **Replace `String.fromEnvironment('env')`** in [flutter_module/lib/src/app_initializer.dart:22](flutter_module/lib/src/app_initializer.dart) with a one-time async fetch via MethodChannel `in.cashify.trc/plugin` method `getFlavor`. Cache in a top-level `String currentFlavor`. Pattern:
  ```dart
  static String? _flavor;
  static Future<String> getFlavor() async {
    _flavor ??= await const MethodChannel('in.cashify.trc/plugin')
        .invokeMethod<String>('getFlavor');
    return _flavor ?? 'prod';
  }
  ```
  Await this BEFORE `runApp(CashifyApp(appName))` in [flutter_module/lib/main.dart](flutter_module/lib/main.dart).
- Audit [flutter_module/lib/src/channel/channel.dart](flutter_module/lib/src/channel/channel.dart) (`in.cashify.flutter_boilerplate/plugin` / `getPlatform`). Grep for usage; if unused, delete the file. If used, port the `getPlatform` handler to `FlutterEngineManager`.
- Keep [flutter_module/lib/src/channel/native_communication.dart](flutter_module/lib/src/channel/native_communication.dart) (`compressVideo`) untouched — Dart contract is preserved.
- Build module locally: `cd flutter_module && flutter pub get && flutter build aar --no-debug --no-profile`. Confirm artifacts under `flutter_module/build/host/outputs/repo/in/cashify/androidtrc/...`.
- Build iOS framework: `flutter build ios-framework --no-debug --no-profile --output=flutter_module/build/ios-framework`.

**Plugin audit policy:** Keep all plugins as-is. Smoke test during Phase 8; fix any add-to-app issues at that point. Highest-risk plugins to watch: `ffmpeg_kit_flutter_*` (APK size), `video_compress`, `ml_barcode_scanner`, `local_auth`.

---

## Phase 3 — Android Integration

### 3.1 settings.gradle — pre-built AAR approach
- Standard RN autolinking only.
- **Do NOT** add `include_flutter.groovy` source build.
- Add the Flutter module's AAR repo as a maven repo in `android/build.gradle` `allprojects.repositories`:
  ```groovy
  maven { url '../flutter_module/build/host/outputs/repo' }
  maven { url "${System.getProperty('user.home')}/.pub-cache/hosted/pub.dev" }
  ```

### 3.2 android/app/build.gradle
- `namespace "in.cashify.androidtrc"`, `applicationId "in.cashify.androidtrc"`.
- `flavorDimensions += "tier"` with 3 productFlavors:
  - `prod` → no suffix → `in.cashify.androidtrc`
  - `beta` → `applicationIdSuffix ".beta"` → `in.cashify.androidtrc.beta`
  - `stage` → `applicationIdSuffix ".stage"` → `in.cashify.androidtrc.stage`
- Build types: only `debug` and `release` (drop `staging`).
- Match existing native config: `compileSdk 36`, `minSdk 24`, NDK `27.0.12077973`, Kotlin `2.0.0`, AGP/Gradle `8.12`, `multiDexEnabled true`, `dataBinding { enabled true }`, `coreLibraryDesugaringEnabled true`.
- Dependencies (in addition to RN defaults):
  ```groovy
  implementation 'in.cashify.androidtrc:flutter_release:1.0'    // pre-built AAR
  implementation platform('com.google.firebase:firebase-bom:33.x.x')
  implementation 'com.google.firebase:firebase-analytics-ktx'
  implementation 'com.google.firebase:firebase-crashlytics-ktx'
  implementation 'androidx.appcompat:appcompat:1.6.1'
  coreLibraryDesugaring 'com.android.tools:desugar_jdk_libs:2.1.4'
  ```
- `react { debuggableVariants = ["prodDebug", "betaDebug", "stageDebug"] }`.
- `packagingOptions.jniLibs.useLegacyPackaging true` + pickFirsts for `libc++_shared.so` (preserve from existing).
- `configurations.all.resolutionStrategy.force` lines preserved from [android_flutter_backup/app/build.gradle:130-138](android_flutter_backup/app/build.gradle).

### 3.3 Signing
- Load credentials from `android/local.properties` in `android/build.gradle` `buildscript` block. Required keys (same names as Flutter project):
  - `sdk.dir`, `CASHIFY_TEST`, `CASHIFY_STAGE`, `CASHIFY_PROD`
  - `SIGNING_CONFIGS_KEY_ALIAS`, `SIGNING_CONFIGS_KEY_PASSWORD`, `SIGNING_CONFIGS_STORE_PASSWORD`
  - `flutter.versionName`, `flutter.versionCode`
- Two signingConfigs:
  - `cashify` → assigned to `prod` and `beta`
  - `stage` → assigned to `stage`
- Fall back to debug keystore if `local.properties` is missing.
- `local.properties` MUST be gitignored.

### 3.4 Native Kotlin files
Create under `android/app/src/main/java/in/cashify/androidtrc/`:

- **`CopsApp.kt`** — Application class. Ports `TrcApp` logic (StrictMode VmPolicy + WeakReference context singleton) and adds RN's `ReactApplication` interface + Flutter engine pre-warm:
  ```kotlin
  class CopsApp : Application(), ReactApplication {
    override fun onCreate() {
      super.onCreate()
      // ... TrcApp StrictMode setup ...
      FlutterEngineManager.prewarm(this)
    }
  }
  ```
- **`MainActivity.kt`** — RN `ReactActivity` (NEW, replaces Flutter's MainActivity entirely). On `onCreate`, immediately starts `CopsFlutterActivity` with `FLAG_ACTIVITY_NO_ANIMATION` and finishes itself (Phase 5 confirms exact transition strategy).
- **`flutter/FlutterEngineManager.kt`** — Singleton:
  - Calls `FlutterLoader.startInitialization()` + `ensureInitializationComplete()` BEFORE creating the engine (CRITICAL for pre-built AAR — Gap #12 from source plan).
  - Creates and caches `FlutterEngine` keyed `"cops_engine"` via `FlutterEngineCache`.
  - Registers MethodChannel `in.cashify.trc/plugin` on the engine's `binaryMessenger` with handlers:
    - `userauthdetails` — port from [android_flutter_backup/app/src/main/kotlin/in/cashify/androidtrc/MainActivity.kt:38-41](android_flutter_backup/app/src/main/kotlin/in/cashify/androidtrc/MainActivity.kt)
    - `registerLogout` — port from [android_flutter_backup/app/src/main/kotlin/in/cashify/androidtrc/MainActivity.kt:43-46](android_flutter_backup/app/src/main/kotlin/in/cashify/androidtrc/MainActivity.kt). The `MethodChannel.Result` is stored in `CopsLogoutBridge` (see below).
    - `compressVideo` — delegates to `video_compress` plugin (already registered via GeneratedPluginRegistrant inside the AAR).
    - `getFlavor` — returns `BuildConfig.FLAVOR` (`"prod"|"beta"|"stage"`).
    - `getVideoBitrate` — port `MediaMetadataRetriever` helper from [android_flutter_backup/app/src/main/kotlin/in/cashify/androidtrc/MainActivity.kt:52-64](android_flutter_backup/app/src/main/kotlin/in/cashify/androidtrc/MainActivity.kt) if it's invoked from Dart (grep first; if not, drop).
- **`flutter/CopsLogoutBridge.kt`** — replaces the existing `TRCDataSingleton.callLogout()` static pattern. Kotlin `object` with `var logoutResult: MethodChannel.Result?` and `fun callLogout()`. Globally callable; will let future RN screens trigger logout in later phases.
- **`flutter/CopsFlutterActivity.kt`** — `class CopsFlutterActivity : FlutterFragmentActivity()`. Use `FlutterFragmentActivity` (NOT `FlutterActivity`) to preserve current `FlutterFragmentActivity` semantics from [android_flutter_backup/app/src/main/kotlin/in/cashify/androidtrc/MainActivity.kt:12](android_flutter_backup/app/src/main/kotlin/in/cashify/androidtrc/MainActivity.kt). Launched via `FlutterFragmentActivity.withCachedEngine("cops_engine").build(context)`. Theme: LaunchTheme → NormalTheme, `screenOrientation="portrait"`.
- **`flutter/CopsFlutterModule.kt`** — RN native module. Single method `launchFlutter()` that starts `CopsFlutterActivity`.
- **`flutter/CopsFlutterPackage.kt`** — standard RN `ReactPackage` registering `CopsFlutterModule`. Added to `getPackages()` in `MainApplication`.

### 3.5 AndroidManifest.xml (`android/app/src/main/AndroidManifest.xml`)
- Application class: `android:name=".CopsApp"`.
- Launcher activity: RN's `MainActivity` (exported=true, launchMode singleTask, portrait, LaunchTheme).
- Register `CopsFlutterActivity` (NOT exported, theme `@style/LaunchTheme` with NormalTheme metadata, `screenOrientation="portrait"`).
- FileProvider with authority `${applicationId}.provider` referencing `res/xml/file_provider.xml` — copy [android_flutter_backup/app/src/main/res/xml/file_provider.xml](android_flutter_backup/app/src/main/res/xml/file_provider.xml) verbatim.
- Permissions to copy verbatim: `INTERNET`, `CAMERA`, `READ_EXTERNAL_STORAGE`, `WRITE_EXTERNAL_STORAGE`, `WAKE_LOCK`.
- `<queries>` to copy: `ACTION_IMAGE_CAPTURE`, `ACTION_PICK image/*`, `VIEW https`.
- Meta-data to copy:
  - `com.google.mlkit.vision.DEPENDENCIES` = `ica,ocr,face,subject_segment`
  - `io.fabric.ApiKey` (Crashlytics) — from [android_flutter_backup/app/src/main/AndroidManifest.xml](android_flutter_backup/app/src/main/AndroidManifest.xml)
  - `flutterEmbedding` = `2`
  - `io.flutter.embedding.android.NormalTheme` = `@style/NormalTheme`
  - `io.flutter.embedding.android.SplashScreenDrawable` = `@drawable/launch_background`
- Flags: `allowBackup="false"`, `usesCleartextTraffic="true"`, `extractNativeLibs="true"`, `supportsRtl="true"`.

### 3.6 Resources
Copy from `android_flutter_backup/app/src/`:

| Source | Destination |
|---|---|
| `main/res/mipmap-{m,h,xh,xxh,xxxh}dpi/ic_launcher.png` + `ic_launcher_round.png` | `android/app/src/main/res/mipmap-*/` |
| `main/res/drawable-v24/ic_launcher_foreground.xml` | same |
| `main/res/drawable/launch_background.xml` | same |
| `main/res/xml/file_provider.xml` | same |
| `main/res/values/colors.xml` (colorPrimary, consoleThemePrimary, teal, runnerColorPrimary) | same |
| `main/res/values/styles.xml` (LaunchTheme, NormalTheme, AppTheme.NoActionBar, ToolbarTheme) | same |
| `beta/res/mipmap-*/` + `beta/res/values/strings.xml` | `android/app/src/beta/res/` |
| `stage/res/mipmap-*/` + `stage/res/values/strings.xml` | `android/app/src/stage/res/` |
| `prod/res/values/strings.xml` | `android/app/src/prod/res/` (only `app_name`) |

App names per flavor strings.xml:
- main + prod: `Cashify-OPS`
- beta: `Cashify-OPS Beta`
- stage: `Cashify-OPS Stage`

### 3.7 Firebase config
- Copy single `google-services.json` from `android_flutter_backup/app/google-services.json` to `android/app/google-services.json`. NOT per-flavor — preserves current simplicity.
- Apply `com.google.gms.google-services` + `com.google.firebase.crashlytics` plugins in `android/app/build.gradle`.

### 3.8 ProGuard
- Copy [android_flutter_backup/app/proguard-rules.pro](android_flutter_backup/app/proguard-rules.pro) to `android/app/proguard-rules.pro`. Append RN/Hermes keeps:
  ```proguard
  -keep class com.facebook.react.** { *; }
  -keep class com.facebook.hermes.** { *; }
  -keep class com.facebook.jni.** { *; }
  ```

### 3.9 Back button
- When user presses back from Flutter at root, `CopsFlutterActivity` finishes. RN's `MainActivity` was already finished after launching it. App goes to background — correct behavior.

---

## Phase 4 — iOS Integration (Single Target + 3 Schemes + xcconfigs)

### 4.1 Re-architect from 4 targets to 1
- The current project has 4 targets (`Runner`, `Runner Prod`, `Runner Beta`, `Runner Stage`). The new RN host uses **1 target** (`CashifyOps`) with **3 schemes** and **xcconfigs**.

### 4.2 xcconfig files (`ios/Config/`)
- `Shared.xcconfig` — `IPHONEOS_DEPLOYMENT_TARGET = 16.0`, common settings.
- `Prod.xcconfig`:
  ```
  PRODUCT_BUNDLE_IDENTIFIER = in.cashify.iostrc
  DISPLAY_NAME = Cashify Ops
  ```
- `Beta.xcconfig`:
  ```
  PRODUCT_BUNDLE_IDENTIFIER = in.cashify.iostrc.beta
  DISPLAY_NAME = Cashify Ops Beta
  ```
- `Stage.xcconfig`:
  ```
  PRODUCT_BUNDLE_IDENTIFIER = in.cashify.iostrc.stage
  DISPLAY_NAME = Cashify Ops Stage
  ```

### 4.3 Schemes
Create 3 schemes via Xcode: `Cashify Ops Prod` / `Cashify Ops Beta` / `Cashify Ops Stage`. Each sets the appropriate xcconfig per build configuration (Debug + Release).

### 4.4 Info.plist
Single `ios/CashifyOps/Info.plist`. Use `$(PRODUCT_BUNDLE_IDENTIFIER)` and `$(DISPLAY_NAME)` substitution. Merge all keys from the 3 current plists ([ios_flutter_backup/Runner/Prod-Info.plist](ios_flutter_backup/Runner/Prod-Info.plist), `Beta-Info.plist`, `Stage-Info.plist`): camera/photo/microphone usage strings, ATS exceptions, any URL schemes, background modes.

### 4.5 GoogleService-Info.plist
Single `ios/CashifyOps/GoogleService-Info.plist` (preserve current single-file simplicity from [ios_flutter_backup/GoogleService-Info.plist](ios_flutter_backup/GoogleService-Info.plist)). If Firebase project differs per flavor later, add a Run Script Build Phase to swap by configuration.

### 4.6 Podfile (`ios/Podfile`)
```ruby
platform :ios, '16.0'
ENV['USE_FRAMEWORKS'] = 'static'   # static linkage — resolves use_frameworks! conflict

require_relative '../node_modules/@react-native-community/cli-platform-ios/native_modules'

target 'CashifyOps' do
  use_react_native!(
    :path => '../node_modules/react-native',
    :hermes_enabled => true,
    :fabric_enabled => true,
    :new_arch_enabled => true,
  )

  # Flutter module pods
  flutter_application_path = '../flutter_module'
  load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
  install_all_flutter_pods(flutter_application_path)
end

post_install do |installer|
  react_native_post_install(installer, '../node_modules/react-native', :mac_catalyst_enabled => false)
  flutter_post_install(installer) if defined?(flutter_post_install)

  installer.pods_project.targets.each do |t|
    t.build_configurations.each do |bc|
      bc.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
    end
  end
end
```

### 4.7 Native Swift files
Create under `ios/CashifyOps/`:

- **`AppDelegate.swift`** — RN AppDelegate + Flutter engine pre-warm:
  ```swift
  @main
  class AppDelegate: RCTAppDelegate {
    let copsEngine = FlutterEngine(name: "cops_engine")

    override func application(_ app: UIApplication,
                              didFinishLaunchingWithOptions opts: [...]) -> Bool {
      FirebaseApp.configure()
      copsEngine.run()
      GeneratedPluginRegistrant.register(with: copsEngine)
      CopsFlutterEngineManager.shared.registerChannels(on: copsEngine)
      // ... RN init ...
      return super.application(app, didFinishLaunchingWithOptions: opts)
    }
  }
  ```
- **`CopsFlutterEngineManager.swift`** — registers MethodChannel `in.cashify.trc/plugin` on the cached engine with handlers for `userauthdetails`, `registerLogout`, `compressVideo`, `getFlavor` (reads from `Bundle.main.infoDictionary["DISPLAY_NAME"]` or a flavor key injected by xcconfig).
- **`CopsLogoutBridge.swift`** — `final class CopsLogoutBridge { static let shared = ...; func callLogout() }`. Mirrors the Android `CopsLogoutBridge` static pattern; invokes the channel from anywhere.
- **`CopsFlutterModule.swift`** + **`CopsFlutterModule.m`** — RN native module exposing `launchFlutter()`. Implementation:
  ```swift
  let vc = FlutterViewController(engine: copsEngine, nibName: nil, bundle: nil)
  vc.modalPresentationStyle = .fullScreen
  rootVC.present(vc, animated: false, completion: nil)
  ```

### 4.8 Assets
- Copy `ios_flutter_backup/Runner/Assets.xcassets/AppIcon.appiconset/` (all icon sizes) to `ios/CashifyOps/Assets.xcassets/`.
- Copy `Base.lproj/LaunchScreen.storyboard` if present.
- Skip notification extensions — none exist in this project.

---

## Phase 5 — RN Shell

### 5.1 src/App.tsx
```tsx
import { useEffect } from 'react';
import { View } from 'react-native';
import { launchFlutter } from './native/CopsFlutterModule';

const App = () => {
  useEffect(() => { launchFlutter(); }, []);
  return <View style={{ flex: 1, backgroundColor: '#0080F0' }} />;
};

export default App;
```
Background color matches `consoleThemePrimary` (`#0080F0`) so any flash blends with the launch theme.

### 5.2 src/native/CopsFlutterModule.ts
```ts
import { NativeModules } from 'react-native';
const { CopsFlutter } = NativeModules;
export const launchFlutter = () => CopsFlutter.launchFlutter();
```

### 5.3 index.js
```js
import { AppRegistry } from 'react-native';
import App from './src/App';
AppRegistry.registerComponent('CashifyOps', () => App);
```

### 5.4 Shared fonts (Montserrat)
- Single source of truth: `flutter_module/assets/fonts/montserrat_{regular,medium,semi_bold}.ttf` (already there).
- Symlink: `mkdir -p src/assets && ln -s ../../flutter_module/assets/fonts src/assets/fonts`.
- `react-native.config.js`:
  ```js
  module.exports = {
    project: { ios: {}, android: {} },
    assets: ['./flutter_module/assets/fonts/'],
  };
  ```
- Run `yarn add -D react-native-asset` and `npx react-native-asset` to link fonts into Android `app/src/main/assets/fonts/` and Xcode project.

---

## Phase 6 — Build Scripts

Create `scripts/build.sh` accepting `FLAVOR` (prod/beta/stage) and `PLATFORM` (android/ios):

```bash
set -e
FLAVOR="${FLAVOR:-prod}"
PLATFORM="${PLATFORM:-android}"

yarn install --immutable
(cd flutter_module && flutter pub get && flutter build aar --no-debug --no-profile --obfuscate --split-debug-info=build/symbols)

if [ "$PLATFORM" = "android" ]; then
  (cd android && ./gradlew assemble${FLAVOR^}Release)
elif [ "$PLATFORM" = "ios" ]; then
  (cd flutter_module && flutter build ios-framework --no-debug --no-profile --obfuscate --split-debug-info=build/symbols)
  (cd ios && pod install)
  xcodebuild -workspace ios/CashifyOps.xcworkspace -scheme "Cashify Ops ${FLAVOR^}" -configuration Release archive
fi
```

- Port Firebase App Distribution and Crashlytics symbol upload steps from [flutter_module/../scripts/flutter_build.sh](scripts/flutter_build.sh) (the original).
- Update `jenkinfile.groovy` to call this new `scripts/build.sh`; preserve `FLAVOR` / `PLATFORM` / `EXPORT_TYPE` Jenkins parameter names.

`.gitignore` additions:
```
node_modules/
.yarn/cache/
.yarn/install-state.gz
ios/Pods/
ios/build/
android/build/
android/app/build/
flutter_module/.android/
flutter_module/.ios/
flutter_module/build/
android/local.properties
*.keystore
```

---

## Phase 7 — Developer Workflow

Create `docs/DEVELOPER_WORKFLOW.md` covering:

- **Prereqs:** Node 20 LTS, Flutter SDK (same version current project uses), Xcode 16+, Android Studio with NDK `27.0.12077973`, JDK 17, CocoaPods.
- **First-time setup:**
  ```bash
  cd flutter_module && flutter pub get && flutter build aar --no-debug --no-profile
  cd .. && yarn install
  cd ios && pod install
  ```
  Then on Android: `cd .. && yarn android` (or scheme-specific gradle command).
- **Daily Dart work:** Edit `flutter_module/lib/`. For hot reload during a running RN-host launch, use `cd flutter_module && flutter attach`. For full integration test, rebuild AAR.
- **Daily RN work:** Standard Metro hot reload via `yarn start`. (RN host is essentially empty in Phase 1; this matters for later phases.)
- **Daily native work:** Edit Kotlin/Swift in `android/` or `ios/`; rebuild via `yarn android` / `yarn ios`.
- **Running per flavor (Android):** `cd android && ./gradlew installStageDebug` etc.
- **Running per flavor (iOS):** Open `ios/CashifyOps.xcworkspace` in Xcode, select scheme, build & run.

---

## Phase 8 — Validation

### Smoke matrix (must pass before declaring Phase 1 complete)
3 flavors × 2 platforms = **6 install/launch combinations**.

For each combination verify:
1. Install over previous pure-Flutter build → **no uninstall required** (package ID preserved).
2. Cold-start launch → Flutter UI within 1 frame, no double-splash, no extra flash beyond pre-migration baseline.
3. App display name on home screen matches identity table above.
4. Per-flavor launcher icon is correct.

### Feature smoke checklist (run on at least 1 flavor per platform)
- Login → `userauthdetails` MethodChannel returns expected payload.
- Trigger logout from Flutter → `CopsLogoutBridge.callLogout()` static path fires; Dart-side `onLogout` handler invoked.
- `image_picker` camera capture works (Camera permission flow intact).
- `compressVideo` round-trip works (Dart → channel → native plugin → result).
- `ml_barcode_scanner` scans a QR/barcode (MLKit deps intact).
- `flutter_tts` speaks (audio output).
- `local_auth` biometric prompt appears.
- `file_picker` opens system picker.
- `cached_network_image` loads from network.
- `qr_flutter` renders.
- Firebase Crashlytics: force a test crash → surfaces in console within 5 min.
- Firebase Remote Config: a known key resolves to expected value.
- Firebase Analytics: at least one `screen_view` event arrives.
- `getFlavor` MethodChannel returns `"prod"` / `"beta"` / `"stage"` matching install.
- Montserrat font renders identically to pre-migration screenshots (eyeball login screen).
- Alice network inspector toggles (shake gesture or whatever current trigger is).

### Regression guards
- **APK / IPA size delta** before/after migration; flag if > 15% growth. Expected ~3–6 MB for RN runtime.
- **Cold-start time** on a mid-tier Android device — should be within 200 ms of pre-migration baseline. If much slower, re-check FlutterLoader pre-init timing.
- **Crashlytics dSYM / NDK symbol upload** still works in CI artifacts.
- **`google-services.json` resolution** — verify Firebase still finds it from `android/app/`.
- **ProGuard release build** — no missing class errors at runtime.

### Channel parity check (recommended)
Add a Dart integration test invoking each of: `getFlavor`, `userauthdetails`, `compressVideo` (tiny sample asset), `registerLogout` (assert callback fires after triggering `CopsLogoutBridge.callLogout()` from native test code).

---

## Critical Files

### To be created
- `package.json`, `app.json`, `index.js`, `metro.config.js`, `tsconfig.json`, `babel.config.js`, `react-native.config.js`, `.yarnrc.yml`
- `src/App.tsx`, `src/native/CopsFlutterModule.ts`
- `src/assets/fonts` (symlink to `flutter_module/assets/fonts`)
- `android/build.gradle`, `android/settings.gradle`, `android/gradle.properties`, `android/local.properties` (template)
- `android/app/build.gradle`, `android/app/proguard-rules.pro`
- `android/app/src/main/AndroidManifest.xml`
- `android/app/src/main/java/in/cashify/androidtrc/CopsApp.kt`
- `android/app/src/main/java/in/cashify/androidtrc/MainActivity.kt`
- `android/app/src/main/java/in/cashify/androidtrc/flutter/FlutterEngineManager.kt`
- `android/app/src/main/java/in/cashify/androidtrc/flutter/CopsFlutterActivity.kt`
- `android/app/src/main/java/in/cashify/androidtrc/flutter/CopsFlutterModule.kt`
- `android/app/src/main/java/in/cashify/androidtrc/flutter/CopsFlutterPackage.kt`
- `android/app/src/main/java/in/cashify/androidtrc/flutter/CopsLogoutBridge.kt`
- `android/app/src/{main,prod,beta,stage}/res/...`
- `android/app/google-services.json`
- `ios/Podfile`, `ios/Config/{Shared,Prod,Beta,Stage}.xcconfig`
- `ios/CashifyOps/AppDelegate.swift`, `Info.plist`, `GoogleService-Info.plist`, `Assets.xcassets/`
- `ios/CashifyOps/CopsFlutterEngineManager.swift`, `CopsFlutterModule.swift`, `CopsFlutterModule.m`, `CopsLogoutBridge.swift`
- `ios/CashifyOps.xcodeproj/...` with 3 schemes
- `scripts/build.sh`
- `docs/DEVELOPER_WORKFLOW.md`

### To be modified (Flutter side)
- `flutter_module/pubspec.yaml` — add module descriptor
- `flutter_module/lib/main.dart` — await `getFlavor()` before `runApp`
- `flutter_module/lib/src/app_initializer.dart` — replace `String.fromEnvironment` with MethodChannel
- `flutter_module/lib/src/channel/channel.dart` — delete if dead code; verify first
- `jenkinfile.groovy` — point at new `scripts/build.sh`

### To reference (read-only) — sources for porting
- `android_flutter_backup/app/src/main/kotlin/in/cashify/androidtrc/MainActivity.kt`
- `android_flutter_backup/app/src/main/kotlin/in/cashify/androidtrc/TrcApp.kt`
- `android_flutter_backup/app/build.gradle`
- `android_flutter_backup/app/src/main/AndroidManifest.xml`
- `android_flutter_backup/app/proguard-rules.pro`
- `android_flutter_backup/app/src/main/res/{xml,values,drawable*,mipmap-*}/`
- `android_flutter_backup/app/src/{prod,beta,stage}/res/`
- `ios_flutter_backup/Runner/AppDelegate.swift`
- `ios_flutter_backup/Runner/{Prod,Beta,Stage}-Info.plist`
- `ios_flutter_backup/Podfile`
- `flutter_module/assets/fonts/montserrat_*.ttf`
- `scripts/flutter_build.sh` (original)

---

## Verification

Run end-to-end after Phase 8 checklist:
```bash
# Build all flavors Android
FLAVOR=prod PLATFORM=android ./scripts/build.sh
FLAVOR=beta PLATFORM=android ./scripts/build.sh
FLAVOR=stage PLATFORM=android ./scripts/build.sh

# Build all flavors iOS
FLAVOR=prod PLATFORM=ios ./scripts/build.sh
FLAVOR=beta PLATFORM=ios ./scripts/build.sh
FLAVOR=stage PLATFORM=ios ./scripts/build.sh

# Smoke a stage install on Android device
cd android && ./gradlew installStageDebug
adb shell am start -n in.cashify.androidtrc.stage/in.cashify.androidtrc.MainActivity
```

Walk through the Phase 8 feature smoke checklist on a real device per platform. Compare APK/IPA size, cold-start time, and feature parity against the pre-migration baseline. Only then declare Phase 1 done and tag a release.

---

## Phase 9 — Lessons from Execution (READ THIS FIRST on a future migration)

The plan above was followed and the Android side was successfully brought up. Along the way, **eleven non-obvious issues** surfaced that the original plan didn't account for. Use this section as the "known gotchas" checklist for any future Flutter → RN add-to-app migration. They are listed roughly in the order you will hit them.

### G1 — AGP 8 requires `namespace` in every plugin's `build.gradle`

**Symptom:** AAR build fails on a plugin (often `text_recognizer`, via a transitive git-dep) with `Namespace not specified. Specify a namespace in the module's build file`.

**Cause:** AGP 8 deprecated `package="..."` in `AndroidManifest.xml` and requires `namespace = "..."` in the plugin's `android/build.gradle`. Many older Flutter plugins haven't been updated.

**Fix:** Patch `flutter_module/.android/build.gradle` with a `subprojects { afterEvaluate {} }` block that injects a default namespace into every subproject missing one:

```groovy
subprojects {
    afterEvaluate { project ->
        if (project.hasProperty("android")) {
            project.android {
                if (namespace == null) {
                    namespace = project.group ?: "com.example.${project.name.replaceAll('-', '_')}"
                }
            }
        }
    }
}
```

Caveat: `flutter_module/.android/` is auto-generated by `flutter create --template module`. The patch must be re-applied if you regenerate. Document this in `docs/DEVELOPER_WORKFLOW.md`.

### G2 — AGP 8 also rejects `package="..."` in plugin manifests

**Symptom:** Build fails with `Setting the namespace via the package attribute in the source AndroidManifest.xml is no longer supported. Recommendation: remove package="..."`.

**Cause:** AGP 8 needs both halves of the namespace migration — `namespace` set in build.gradle (G1) AND `package=` removed from `AndroidManifest.xml`. G1 only fixed half.

**Fix:** Ship a `scripts/patch_pub_cache_manifests.sh` script that strips `package="..."` from `~/.pub-cache/git/<plugin-repo>-*/*/android/src/main/AndroidManifest.xml` (idempotent). Wire it into `scripts/build.sh` so it runs automatically on every CI build. Re-run after `flutter pub cache repair` / fresh git SHAs.

Affected plugins (anything that hasn't been updated in 2+ years):
- Cashify-internal: `text_recognizer`, `face_detector`, `csh_jus_pay`, `csh_payment_gateway`, `csh_razor_pay`, `udid`, `device_cpu_detail` (all from `reglobe/flutter_plugins`)
- Generalize on a future project: look for any plugin checked out under `~/.pub-cache/git/` whose `AndroidManifest.xml` still has a `package=` attribute.

### G3 — Pre-built AAR cross-project consumption breaks plugins that use flat-file Gradle deps

**Symptom:** Host gradle build fails with one of:
- `Could not parse module metadata ... Expected a string but was NULL at line N column M path $.variants[0].dependencies[1].group` (Gradle Metadata)
- `Missing required attribute: dependency groupId` (POM)
- `Could not find <plugin-local-maven-coords>` (e.g. `com.arthenica.ffmpegkit:flutter:6.0`)

**Cause:** Some plugins use Gradle patterns that only work inside a single multi-project build:
- **Flat-file deps:** `api(name: 'tesseract4android-release', ext: 'aar')` references a `libs/*.aar` shipped with the plugin. The generated AAR's POM/`.module` has a `<dependency>` with no `<groupId>` because there are no Maven coordinates. Consumer-side AGP rejects this.
- **Plugin-local maven publishing:** plugins like `ffmpeg_kit_flutter_android` run a `setupDependencies` Gradle task that downloads native AARs and publishes them to a plugin-local `build/` maven dir. That dir never gets exported, so the host can't resolve the artifact.

**Fix:** Ship a `scripts/fix_aar_artifacts.sh` that runs AFTER `flutter build aar` and BEFORE `./gradlew assemble*`. It must:

1. **For each Flutter build variant (release / debug / profile)**, for each broken plugin:
   - Strip the malformed `<dependency>` block from `<plugin>-<variant>-1.0.pom`
   - Delete the `<plugin>-<variant>-1.0.module` file (Gradle Module Metadata) so Gradle falls back to the patched POM (Gradle prefers `.module` when present)
   - Don't forget the `.module.md5`, `.module.sha1`, `.module.sha256`, `.module.sha512` siblings
2. **Copy plugin-local maven artifacts** into the shared AAR repo:
   - Source: `~/.pub-cache/hosted/pub.dev/<plugin>/<version>/android/build/<group>/<artifact>/<version>/`
   - Destination: `flutter_module/build/host/outputs/repo/<group>/<artifact>/<version>/`

**Critical:** This script must handle ALL the AAR variants you build. Building with `--no-profile` produces both `flutter_<plugin>_debug` AND `flutter_<plugin>_release` artifacts — each needs patching. The script must loop over `release`, `debug`, `profile`.

**Long-term fix:** Fork the offending plugins and update them to use proper Maven coords. Until then, this script is the bridge.

### G4 — `maven { url '../...' }` in `allprojects.repositories` resolves PER-SUBPROJECT, not from root

**Symptom:** Host build fails with `Could not find <flutter-aar-coords>` despite the AAR existing on disk. The error path shows Gradle looked in `android/flutter_module/...` instead of `repo-root/flutter_module/...`.

**Cause:** Gradle resolves relative `maven { url }` URLs **relative to the subproject's `projectDir`**. The `:app` subproject's `projectDir` is `android/app/`, so `../flutter_module` evaluates to `android/flutter_module` (doesn't exist).

**Fix:** Anchor the path to `rootProject.projectDir`:

```groovy
maven { url uri("${rootProject.projectDir}/../flutter_module/build/host/outputs/repo") }
```

Same trick for any other repo-relative path declared in `allprojects.repositories`.

### G5 — Pre-warmed cached engine breaks ActivityAware plugins

**Symptom (runtime, NOT build):** First call from Dart into any ActivityAware plugin throws `java.lang.NullPointerException` like `Attempt to invoke virtual method 'int Context.checkPermission(...)' on a null object reference` — coming from `flutter_local_notifications.requestNotificationsPermission`, `image_picker`, `local_auth`, `permission_handler`, etc.

**Cause:** The original plan recommended pre-warming a `FlutterEngine` in `Application.onCreate()` for fast cold start. But this runs **Dart code at App-level**, before any Activity exists. ActivityAware plugins haven't received `onAttachedToActivity` yet, so their `mainActivity` field is null. When Dart calls a plugin method that needs Activity, NPE.

**Fix:** **DO NOT pre-warm** a cached engine for production add-to-app. Instead, have your custom `FlutterFragmentActivity` create its own engine via `configureFlutterEngine()`:

```kotlin
class CopsFlutterActivity : FlutterFragmentActivity() {
  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    // Engine + Dart start AFTER the activity is created, so plugins get a real Activity.
    FlutterEngineManager.configureEngine(flutterEngine, applicationContext)
  }

  companion object {
    fun newIntent(context: Context): Intent =
      Intent(context, CopsFlutterActivity::class.java)   // no withCachedEngine!
  }
}
```

Cost: cold start adds ~200ms vs pre-warming. Worth it — eliminates an entire class of plugin crashes.

**The original plan's "Phase 3.5 — FlutterLoader init before engine" recommendation is therefore moot.** Without pre-warming there's no need to manually initialize `FlutterLoader`; Flutter's Gradle plugin handles it on the activity's first `onCreate()`.

### G6 — RN's `ReactActivity` requires a `Theme.AppCompat.*` theme; Flutter's `LaunchTheme` is plain Android

**Symptom (runtime, on RN MainActivity launch):** `java.lang.IllegalStateException: You need to use a Theme.AppCompat theme (or descendant) with this activity` — at `AppCompatDelegateImpl.createSubDecor`.

**Cause:** The original Flutter `LaunchTheme` extends `@android:style/Theme.Light.NoTitleBar` (plain Android, not AppCompat). `FlutterFragmentActivity` is fine with that, but RN's `ReactActivity` → `AppCompatActivity` rejects non-AppCompat themes.

**Fix:** Add a parallel AppCompat-based launch theme that uses the same `@drawable/launch_background` for visual parity:

```xml
<style name="LaunchThemeAppCompat" parent="Theme.AppCompat.Light.NoActionBar">
    <item name="windowActionBar">false</item>
    <item name="windowNoTitle">true</item>
    <item name="android:windowBackground">@drawable/launch_background</item>
</style>
```

Use `LaunchThemeAppCompat` for the RN `MainActivity` in `AndroidManifest.xml`. Keep the original `LaunchTheme` for `CopsFlutterActivity` (since FlutterFragmentActivity doesn't require AppCompat).

### G7 — RN 0.83 module API surface changes

**Symptom (Kotlin compile-time):**
- `Unresolved reference 'currentActivity'` in code extending `ReactContextBaseJavaModule`
- `Unresolved reference 'applicationContext'` on `FlutterEngine`

**Cause:**
- `currentActivity` is exposed via `reactApplicationContext.currentActivity`, not as a direct property on `ReactContextBaseJavaModule` in RN 0.83.
- `FlutterEngine` does NOT have an `applicationContext` accessor. Capture the context yourself when configuring the engine.

**Fix:**

```kotlin
// In a RN module:
val activity = reactApplicationContext.currentActivity ?: return

// In a Flutter engine manager:
object FlutterEngineManager {
  fun configureEngine(engine: FlutterEngine, appContext: Context) {
    // Use the appContext passed in, do not look it up via engine.applicationContext
  }
}
```

### G8 — Resource carryover from backup is easy to miss

**Symptom:** Resource linker fails with `error: resource font/montserrat_medium (aka <pkg>:font/montserrat_medium) not found` (or similar for drawables, raw, anim).

**Cause:** The original Flutter project had a `res/font/` directory with TTFs referenced from `styles.xml`'s `ActionBarTextAppearance`. Copying `mipmap-*`, `drawable*`, `values*`, `xml` dirs from backup is the obvious set, but small auxiliary dirs (`font/`, `raw/`, `anim/`) are easy to overlook.

**Fix:** Use a comprehensive `cp -R` of every subdir of `android_flutter_backup/app/src/main/res/` that isn't auto-generated by RN. Audit checklist:
- `mipmap-*`, `mipmap-anydpi-v26` (icons)
- `drawable`, `drawable-v24`, `drawable-night`, `drawable-hdpi`/`mdpi`/etc.
- `font`
- `raw`
- `anim`
- `xml` (FileProvider, network_security_config, etc.)
- `values`, `values-night`, `values-v23`, `values-sw*dp`, `values-<lang>`

A safer recipe than my plan's selective cp: copy the whole `res/` tree from backup, then let the build break if anything conflicts.

### G9 — `flutter attach` / hot reload requires the `flutter_debug` AAR, not `flutter_release`

**Symptom:** `flutter attach` says "Waiting for a connection..." and never connects. No hot reload. No `print()` output.

**Cause:** Building with `flutter build aar --no-debug --no-profile` produces ONLY the release AAR, which is AOT-compiled with no Dart VM Service. `flutter attach` connects via the VM Service, so it can't find anything.

**Fix:** Build with `--no-profile` only (skip the profile variant to save time, but keep both debug + release). Then wire per-buildtype dependencies:

```groovy
// android/app/build.gradle
debugImplementation   "<group>:flutter_debug:1.0"
releaseImplementation "<group>:flutter_release:1.0"
```

`scripts/build.sh` should switch flags based on `$BUILD_MODE`:
- `release` host → `flutter build aar --no-debug --no-profile` (faster, release-only)
- `debug` host → `flutter build aar --no-profile` (debug + release variants)

### G10 — `yarn android` doesn't work with product flavors

**Symptom:** `npx react-native run-android` errors trying to pick a variant when there are >1 product flavors.

**Cause:** RN CLI's `run-android` doesn't have flavor-picking logic for projects with multiple `productFlavors`.

**Fix:** Don't use `react-native run-android`. Add per-flavor npm scripts that drive gradle directly:

```json
"android:stage": "yarn build:flutter-aar:stage && cd android && ./gradlew installStageDebug && adb shell am start -n <flavor-applicationId>/<host-package>.MainActivity"
```

Provide a `:fast` variant per flavor that skips the AAR rebuild (use when only native or RN code changed, not Dart):

```json
"android:stage:fast": "cd android && ./gradlew installStageDebug && adb shell am start ..."
```

### G11 — iOS Xcode project (`project.pbxproj`) edits can't reliably be scripted

**Symptom:** Plan asks the script to add Swift sources to the target, register xcconfigs, create schemes, etc. Trying to do this with `xcodebuild`, `plistbuddy`, or hand-editing `project.pbxproj` is fragile.

**Cause:** `project.pbxproj` is a 1000+ line Apple-internal format with specific UUID ordering rules. Any malformed edit and Xcode refuses to open the project. Real-world projects rarely script these.

**Fix:** Accept that iOS has a **one-time manual Xcode wiring** step in your migration. Write the Swift sources and xcconfig files to disk, then document a sequence of clicks for the developer to make in Xcode (add files to target, set xcconfigs per build configuration, create schemes). The migration plan's Phase 4 should NOT try to write a script for this; it should produce documentation in `docs/DEVELOPER_WORKFLOW.md`.

---

## Updated Build Pipeline (CORRECT order, after all gotchas)

```bash
# 1. JS deps (RN side).
yarn install

# 2. Patch pub-cache plugin manifests (G2). Idempotent.
./scripts/patch_pub_cache_manifests.sh

# 3. Flutter module deps + AAR. --no-profile (NOT --no-debug --no-profile)
#    so the debug variant is produced for `flutter attach` (G9).
(cd flutter_module && flutter pub get && flutter build aar --no-profile --dart-define=env=<flavor>)

# 4. Patch the AAR output to fix plugin packaging issues (G3). Handles all
#    Flutter build variants (release + debug). Idempotent.
./scripts/fix_aar_artifacts.sh

# 5. Build + install the host APK.
(cd android && ./gradlew installStageDebug)

# 6. Launch.
adb shell am start -n <flavor-applicationId>/<host-package>.MainActivity

# 7. (Optional) Attach Flutter for hot reload + Dart logs (G9).
(cd flutter_module && flutter attach)
```

---

## Files-touched index (everything that needed changes vs. a vanilla RN init)

### New files (RN host side)
- `scripts/patch_pub_cache_manifests.sh` — G2 fix
- `scripts/fix_aar_artifacts.sh` — G3 fix
- `scripts/build.sh` — combined pipeline
- `android/app/src/main/java/<pkg>/CopsApp.kt` — Application class (no pre-warm; G5)
- `android/app/src/main/java/<pkg>/MainActivity.kt` — RN entry, immediately starts `CopsFlutterActivity` and finishes
- `android/app/src/main/java/<pkg>/flutter/CopsFlutterActivity.kt` — FlutterFragmentActivity, creates its own engine via `configureFlutterEngine` (G5)
- `android/app/src/main/java/<pkg>/flutter/FlutterEngineManager.kt` — registers MethodChannel handlers on the activity's engine (no `prewarm()`)
- `android/app/src/main/java/<pkg>/flutter/CopsLogoutBridge.kt` — replaces the original project's static-callback `TRCDataSingleton.callLogout()` pattern
- `android/app/src/main/java/<pkg>/flutter/CopsFlutterModule.kt` — RN bridge module
- `android/app/src/main/java/<pkg>/flutter/CopsFlutterPackage.kt` — RN ReactPackage
- `src/App.tsx` — minimal RN shell
- `src/native/CopsFlutterModule.ts` — JS bridge wrapper

### Modified files
- `flutter_module/.android/build.gradle` — namespace injection (G1)
- `flutter_module/pubspec.yaml` — added `module:` descriptor
- `android/settings.gradle` — RN autolinking only (no `include_flutter.groovy`)
- `android/build.gradle` — credentials loading + AAR maven repo anchored via `rootProject.projectDir` (G4)
- `android/app/build.gradle` — flavors + signing + ProGuard + per-buildtype Flutter AAR deps (G9)
- `android/app/src/main/res/values/styles.xml` — added `LaunchThemeAppCompat` (G6)
- `android/app/src/main/AndroidManifest.xml` — `MainActivity` uses `LaunchThemeAppCompat`, `CopsFlutterActivity` uses `LaunchTheme` (G6)
- `package.json` — per-flavor `android:<flavor>` + `:fast` scripts (G10)
- `App.tsx`, `index.js`, `app.json` — Cashify-OPS identity
- `.gitignore`, `.yarnrc.yml`

### Critical resources to carry over from `*_flutter_backup/` (G8)
- All of `android_flutter_backup/app/src/main/res/`, including small dirs like `font/`, `raw/`, `anim/`
- `android_flutter_backup/local.properties` (signing creds)
- `android_flutter_backup/app/proguard-rules.pro`
- `android_flutter_backup/app/google-services.json`
- Per-flavor `src/{prod,beta,stage}/res/` icons + strings

### Plugins to keep an eye on (likely culprits for G1/G2/G3)
- Anything from `flutter_plugins` git org (Cashify): `text_recognizer`, `face_detector`, `csh_jus_pay`, `csh_payment_gateway`, `csh_razor_pay`, `udid`, `device_cpu_detail`
- Old standalone plugins: `flutter_tesseract_ocr`, `ffmpeg_kit_flutter_android` (the latter is also abandoned upstream)

### What does NOT need touching (works as-is from the plan)
- iOS Podfile (`use_frameworks!` → `ENV['USE_FRAMEWORKS'] = 'static'` resolves all Pod conflicts on first try)
- iOS xcconfig + scheme files (text files write cleanly; only the Xcode-side wiring is manual — G11)
- Firebase setup (`google-services.json` + `GoogleService-Info.plist` Just Work as long as they're carried over)
- Font symlinking (`src/assets/fonts -> ../../flutter_module/assets/fonts` + `react-native-asset`)

