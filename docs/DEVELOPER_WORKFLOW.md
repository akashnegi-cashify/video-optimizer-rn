# Cashify-OPS — Developer Workflow (Post-Migration)

This repo is now a **React Native host** that embeds the existing **Flutter app as an add-to-app module**. Phase 1 makes RN a thin shell that immediately launches the full Flutter UI; user-visible behavior is identical to before.

---

## 1. Prerequisites

| Tool | Version | Notes |
|---|---|---|
| Node.js | 20 LTS (recommended) | RN 0.83 requires ≥20; this repo has been tested on Node 23 |
| Corepack | bundled with Node | enables Yarn 4 |
| Yarn | **4.6.0** | enforced by `packageManager` in `package.json` |
| Flutter SDK | 3.35.x stable | same as before migration |
| Xcode | 15+ | iOS deployment target is now **16.0** |
| Android Studio | latest | for Gradle JDK |
| JDK | 17 | required by AGP 8 |
| NDK | 27.x | matches `android/build.gradle` `ext.ndkVersion` |
| CocoaPods | 1.15+ | static-framework linkage support |

---

## 2. First-time setup

```bash
# 1. Activate Yarn 4
corepack enable
corepack prepare yarn@4.6.0 --activate

# 2. JS deps
yarn install

# 3. Flutter side: resolve packages and produce the pre-built AAR per flavor.
#    --dart-define=env=<flavor> is what populates `RUNNING_SYSTEM_ENV` inside Dart.
#    fix_aar_artifacts.sh patches known plugin packaging issues afterward.
cd flutter_module
flutter pub get
flutter build aar --no-debug --no-profile --dart-define=env=stage   # or beta / prod
cd ..
./scripts/fix_aar_artifacts.sh

# 4. iOS pods (run from ios/).
cd ios && pod install --repo-update && cd ..

# 5. Link shared fonts (Montserrat + Lato) into native asset locations.
yarn link-assets
```

---

## 3. Daily development

### Editing Dart code (Flutter UI)

```bash
cd flutter_module
flutter attach          # attaches to whichever device is running the cached engine
# Edit lib/**.dart, press 'r' for hot reload, 'R' for hot restart.
```

If `flutter attach` can't find the running engine, rebuild the AAR for the matching flavor and reinstall:
```bash
yarn build:flutter-aar:stage   # or :beta / :prod — picks the right --dart-define=env
cd android && ./gradlew installStageDebug && cd ..
```

### Editing RN / JavaScript code

In Phase 1 the RN UI is intentionally invisible, so this matters only when adding RN screens in later phases.

```bash
yarn start              # Metro bundler
yarn android            # builds + installs (defaults to first flavor + debug)
yarn ios
```

### Editing native (Kotlin / Swift) code

Changes to `android/app/src/main/java/in/cashify/androidtrc/**.kt` or `ios/CashifyOps/*.swift` require a full native rebuild:

```bash
# Android
cd android && ./gradlew installStageDebug && cd ..

# iOS — easiest via Xcode (open ios/CashifyOps.xcworkspace), select scheme, Cmd+R.
```

---

## 4. Building per flavor

### Android

| Flavor | Gradle task |
|---|---|
| prod  debug   | `./gradlew installProdDebug` |
| prod  release | `./gradlew assembleProdRelease` |
| beta  debug   | `./gradlew installBetaDebug` |
| beta  release | `./gradlew assembleBetaRelease` |
| stage debug   | `./gradlew installStageDebug` |
| stage release | `./gradlew assembleStageRelease` |

ApplicationId per flavor:
- prod  → `in.cashify.androidtrc`
- beta  → `in.cashify.androidtrc.beta`
- stage → `in.cashify.androidtrc.stage`

### iOS

Open `ios/CashifyOps.xcworkspace` in Xcode and pick the appropriate scheme:

| Flavor | Scheme name | Bundle ID |
|---|---|---|
| prod  | Cashify Ops Prod  | `in.cashify.iostrc` |
| beta  | Cashify Ops Beta  | `in.cashify.iostrc.beta` |
| stage | Cashify Ops Stage | `in.cashify.iostrc.stage` |

> **One-time iOS Xcode setup required** — see [section 8](#8-one-time-ios-xcode-wiring-required).

### Combined script (CI-friendly)

```bash
FLAVOR=stage PLATFORM=android ./scripts/build.sh
FLAVOR=prod  PLATFORM=ios     ./scripts/build.sh
```

---

## 5. Repo layout

```
flutter_trc/                  # repo root
  package.json                # RN 0.83.1, Yarn 4
  app.json, index.js, App.tsx # RN entry
  react-native.config.js      # font asset linking
  src/                        # RN TypeScript code
    App.tsx                   # Phase 1: empty shell
    native/CopsFlutterModule.ts
    assets/fonts -> ../../flutter_module/assets/fonts   # symlink, single source of truth
  android/                    # RN-host Android project
  ios/                        # RN-host iOS project
  flutter_module/             # Flutter add-to-app module (entire Dart codebase)
    lib/, test/, assets/, pubspec.yaml
    .android/, .ios/          # auto-generated, gitignored
  android_flutter_backup/     # original Android project (kept for reference; can be removed after Phase 8)
  ios_flutter_backup/         # original iOS project (kept for reference; can be removed after Phase 8)
  scripts/build.sh            # combined RN+Flutter build entry point
```

---

## 6. Key cross-platform contracts

### MethodChannel `in.cashify.trc/plugin`

The Flutter app calls into the native host via this channel. Implementations live in `FlutterEngineManager` (Android Kotlin / iOS Swift):

| Method | Description |
|---|---|
| `userauthdetails` | Returns the platform identifier (`"android"` / `"ios"`) |
| `registerLogout` | Registers a Dart callback that native can later trigger via `CopsLogoutBridge.callLogout()` |
| `getFlavor` | Returns `"prod"` / `"beta"` / `"stage"` — REPLACES the old `String.fromEnvironment('env')` compile-time constant |
| `getVideoBitrate` (Android only) | Reads bitrate via `MediaMetadataRetriever` |
| `compressVideo` | Handled by the `video_compress` plugin (registered inside the AAR — do not shadow) |

### Identity reference

| Property | Android | iOS |
|---|---|---|
| Bundle/Package ID (prod / beta / stage) | `in.cashify.androidtrc{,/.beta,/.stage}` | `in.cashify.iostrc{,/.beta,/.stage}` |
| Display name (prod) | `Cashify-OPS` | `Cashify Ops` |
| Display name (beta) | `Cashify-OPS Beta` | `Cashify Ops Beta` |
| Display name (stage) | `Cashify-OPS Stage` | `Cashify Ops Stage` |
| Cached FlutterEngine ID | `cops_engine` | `cops_engine` |

---

## 7. Known caveats

1. **Android: pre-built AAR.** The Dart code + all Flutter plugins are packaged into an AAR by `flutter build aar` (driven by `--dart-define=env=<flavor>` per build). The host Android project consumes it from `flutter_module/build/host/outputs/repo`. Three patches are needed to make the AAR usable by AGP 8 (all run automatically by `scripts/build.sh`):

   - **`flutter_module/.android/build.gradle` namespace patch** — hand-edited to inject `namespace` defaults for plugins missing it under AGP 8 (notably `text_recognizer` via `imei_serial_reader`). The file is gitignored, so the patch must be re-applied if you run `flutter create --template module` again. See the top of that file for the canonical block.

   - **`scripts/patch_pub_cache_manifests.sh`** — strips the deprecated `package="..."` attribute from `flutter_plugins` git-deps' `AndroidManifest.xml` files (`text_recognizer`, `face_detector`, `csh_jus_pay`, `csh_payment_gateway`, `csh_razor_pay`, `udid`, `device_cpu_detail`). Re-run after every `flutter pub cache repair` / pub-cache refresh.

   - **`scripts/fix_aar_artifacts.sh`** — runs AFTER `flutter build aar`. Strips the malformed `tesseract4android-release` flat-file `<dependency>` from `flutter_tesseract_ocr_release-1.0.pom` (it has no `groupId` which AGP rejects), and copies the plugin-local `com.arthenica.ffmpegkit:flutter:6.0` artifact into our shared maven repo so the host can resolve it.

1a. **Why these patches exist** — `flutter_tesseract_ocr` and `ffmpeg_kit_flutter_android` use Gradle patterns (`api(name:..., ext: 'aar')` flat-file deps + plugin-local maven publishing) that work in standalone Flutter builds but break when consumed cross-project from an AAR. Both plugins are dead-weight in this app (`flutter_tesseract_ocr` is only a transitive dep from `imei_serial_reader` where every call is commented out; `ffmpeg_kit_flutter_android` is a `dependency_override` not transitively required by anything `video_optimizer` consumes). They can be dropped later if maintenance becomes painful; for now the patches keep them building.

2. **Single `google-services.json`** — both Android and iOS use one Firebase config per platform (not per-flavor). If product analytics later needs flavor separation, wire a Run Script Build Phase in Xcode + per-flavor `google-services.json` placement in `android/app/src/{prod,beta,stage}/`.

3. **`flutter_downloader`, `firebase_messaging`, deep links, push notifications, WebEngage** — explicitly NOT migrated. They didn't exist in this project; the source plan template covered them and they were dropped.

4. **APK / IPA size** — expect a 3–6 MB Android growth and similar iOS growth from RN's runtime. `ffmpeg_kit_flutter_*` is still the dominant size contributor.

5. **`flutter run` no longer works at repo root** — the Flutter app is now a module, not a standalone application. Use `flutter attach` or rebuild the AAR.

---

## 8. ONE-TIME iOS Xcode wiring required

The xcconfig and Swift source files are committed to git, but the Xcode **project file** (`project.pbxproj`) cannot be edited safely from a script. Complete these steps once in Xcode:

1. **Open** `ios/CashifyOps.xcworkspace`.

2. **Add the new Swift / ObjC sources** to the `CashifyOps` target:
   - `CashifyOps/CopsFlutterEngineManager.swift`
   - `CashifyOps/CopsLogoutBridge.swift`
   - `CashifyOps/CopsFlutterModule.swift`
   - `CashifyOps/CopsFlutterModule.m`

3. **Add the Config xcconfig files** to the project (right-click project → Add Files…, deselect "Copy items if needed"):
   - `ios/Config/Shared.xcconfig`
   - `ios/Config/Prod.xcconfig`
   - `ios/Config/Beta.xcconfig`
   - `ios/Config/Stage.xcconfig`

4. **Create 3 new Build Configurations** (Project → Info → Configurations):
   - `Debug-Prod`, `Release-Prod`     → both based on `Prod.xcconfig`
   - `Debug-Beta`, `Release-Beta`     → both based on `Beta.xcconfig`
   - `Debug-Stage`, `Release-Stage`   → both based on `Stage.xcconfig`
   - Delete the default `Debug` and `Release` (or leave them pointing to `Prod` for fallback).

5. **Create 3 schemes** (Product → Scheme → Manage Schemes…):
   - `Cashify Ops Prod`  — uses `Debug-Prod` / `Release-Prod`
   - `Cashify Ops Beta`  — uses `Debug-Beta` / `Release-Beta`
   - `Cashify Ops Stage` — uses `Debug-Stage` / `Release-Stage`
   - Mark all 3 as Shared so they end up in `xcshareddata/`.

6. **Verify GoogleService-Info.plist** is added to the target (single file, not per-flavor — matches Android `google-services.json`).

7. **Delete old per-flavor Info.plist files** if they were copied over (`Prod-Info.plist`, `Beta-Info.plist`, `Stage-Info.plist`) — the single `CashifyOps/Info.plist` uses `$(PRODUCT_BUNDLE_IDENTIFIER)` and `$(DISPLAY_NAME)` substitution driven by the xcconfigs.

8. **Run `pod install`** if you haven't already, and open the workspace (NOT the project).

---

## 9. CI / Jenkins

`jenkinfile.groovy` still uses the existing `FlutterBuilder` step. Replace its invocation with:

```groovy
sh "FLAVOR=${params.FLAVOR} PLATFORM=${params.PLATFORM} ./scripts/build.sh"
```

`FLAVOR` and `PLATFORM` parameter names are unchanged from the pre-migration job.

---

## 10. Smoke validation checklist (Phase 8)

For each of the 6 install combinations (3 flavors × 2 platforms):

- [ ] Installs over the previous pure-Flutter build without uninstall (package IDs preserved).
- [ ] Cold-start time within 200 ms of pre-migration baseline.
- [ ] Launches into Flutter UI within 1 frame; no double splash.
- [ ] App display name and launcher icon match the [identity reference](#6-key-cross-platform-contracts).
- [ ] Login → `userauthdetails` returns correct platform string.
- [ ] Logout from Flutter triggers `CopsLogoutBridge.callLogout()` correctly.
- [ ] Camera (image_picker) capture works.
- [ ] Video compression round-trips via `compressVideo`.
- [ ] ML barcode scanner reads a QR.
- [ ] Flutter TTS speaks.
- [ ] `local_auth` biometric prompt appears.
- [ ] `file_picker` opens.
- [ ] Firebase Crashlytics records a forced crash.
- [ ] Firebase Remote Config returns expected key.
- [ ] Firebase Analytics logs `screen_view`.
- [ ] `getFlavor` returns the expected flavor string.
- [ ] Montserrat font renders the same as pre-migration.
- [ ] APK / IPA size delta is < 15%.
- [ ] ProGuard release build runs without missing-class crashes.
