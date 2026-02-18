<!-- Document Information -->
<!-- Generated: 2026-02-18 -->
<!-- Version: 6.0.0+83 -->
<!-- Commit: 9ea0c658 -->

# Troubleshooting

## Table of Contents

- [Build Failures](#build-failures)
- [Authentication Issues](#authentication-issues)
- [Environment Mismatch](#environment-mismatch)
- [Development Issues](#development-issues)
- [Clearing and Rebuilding](#clearing-and-rebuilding)
- [Platform Specific Issues](#platform-specific-issues)
- [Related Documents](#related-documents)

## Build Failures

### Analysis Errors

**Problem:** `flutter analyze` reports errors.

**Solution:**
```bash
# Run analysis
flutter analyze

# Common fix: regenerate code
flutter pub run build_runner build --delete-conflicting-outputs

# If import errors: clear and re-resolve
flutter pub get
```

### Missing Dependencies

**Problem:** Package resolution fails.

**Solution:**
```bash
# Clear pub cache
flutter pub cache repair

# Remove lock file
rm pubspec.lock
flutter pub get

# If git dependencies fail, check network access to git repos
```

### Missing .g.dart Files

**Problem:** Compilation errors about missing generated files.

**Solution:**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Flavor Not Found

**Problem:** `Flavor "stage" has no dimension and cannot be matched.`

**Solution:** Verify `android/app/build.gradle` contains `productFlavors` for stage, beta, and prod. Each flavor should be in the same dimension.

### SDK Version Mismatch

**Problem:** `The current Dart SDK version is X.Y.Z. Because flutter_trc requires SDK version >=3.4.3 <4.0.0`

**Solution:**
```bash
flutter upgrade
# Or use FVM
fvm install 3.4.3
fvm use 3.4.3
```

### Code Generation Conflicts

**Problem:** `build_runner` reports conflicting outputs.

**Solution:**
```bash
# Always use --delete-conflicting-outputs
flutter pub run build_runner build --delete-conflicting-outputs
```

## Authentication Issues

### 401 Unauthorized

**Problem:** API calls return 401.

**Possible causes:**
1. SSO token expired
2. Token not properly synced after login
3. Wrong environment (prod token used on stage)

**Solution:**
1. Logout and re-login
2. Check environment matches expected backend
3. Verify `AuthHandler().userAuth` returns a valid token

### Session Expiry Loops

**Problem:** App keeps redirecting to login immediately after login.

**Possible causes:**
1. Token stored but invalid for the current environment
2. Backend rejecting token format
3. Clock skew between device and server

**Solution:**
1. Clear app data and re-login
2. Verify `--dart-define=env` matches the backend you're authenticating against
3. Check device date/time is correct

### Wrong Auth URL

**Problem:** Login fails with network error.

**Solution:**
1. Verify the environment being used (`--dart-define=env=stage`)
2. Check `lib/src/environments/environments.dart` for correct `authUri`
3. Verify network connectivity to the auth endpoint

### MPIN Issues

**Problem:** MPIN verification fails.

**Solution:**
1. Clear app data to reset MPIN state
2. Re-login and set up MPIN again
3. Check backend MPIN service availability

## Environment Mismatch

### Wrong API Endpoint

**Problem:** App connects to wrong backend.

**Solution:**
```bash
# Always specify environment
flutter run --dart-define=env=stage

# Verify in running app (if Alice enabled, check request URLs)
```

### Data Not Found

**Problem:** API returns 404 for known resources.

**Possible cause:** Connected to wrong environment (e.g., stage data doesn't exist in prod).

**Solution:** Verify `--dart-define=env` value matches the environment with your test data.

### Firebase Configuration Mismatch

**Problem:** Firebase initialization fails or wrong analytics project.

**Solution:** Ensure correct `google-services.json` / `GoogleService-Info.plist` files are used for each flavor.

## Development Issues

### Hot Reload Not Working

**Problem:** Changes not reflected after hot reload.

**Possible causes:**
1. Changes in files not covered by hot reload (main.dart, app initialization)
2. Changes to const values
3. Changes to static fields

**Solution:**
```bash
# Hot restart instead
# Press 'R' (capital) in terminal
# Or stop and restart the app
```

### Local Package Changes Not Reflected

**Problem:** Changes to shared packages (flutter_packages, flutter_admin_ui) not visible.

**Solution:**
```bash
# If using local overrides, ensure pubspec.yaml has correct paths
# Then clean and rebuild
flutter clean
flutter pub get
flutter run --dart-define=env=stage
```

### Provider Errors

**Problem:** `ProviderNotFoundException` or `Tried to listen to a value exposed with provider, from outside of the widget tree.`

**Solution:**
1. Ensure the provider is declared above the consuming widget in the tree
2. For screen-scoped providers, check `ChangeNotifierProvider` is at the screen level
3. Use `listen: false` when calling from callbacks

### Stream Subscription Leaks

**Problem:** Memory leaks or callbacks after screen disposal.

**Solution:**
1. Cancel all `StreamSubscription` instances in `dispose()`
2. Check `mounted` before `notifyListeners()` after async operations
3. Always call `super.dispose()` last

### Build Runner Stuck

**Problem:** `build_runner` hangs or runs indefinitely.

**Solution:**
```bash
# Kill running build_runner processes
# Then clean and retry
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

## Clearing and Rebuilding

### Full Clean

```bash
# Clean Flutter build cache
flutter clean

# Remove pub dependencies
rm -rf .dart_tool/
rm -rf build/
rm pubspec.lock

# Re-install and build
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Android Clean

```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### iOS Clean

```bash
cd ios
pod deintegrate
rm -rf Pods/
rm Podfile.lock
pod install --repo-update
cd ..
flutter clean
flutter pub get
```

### Web Clean

```bash
flutter clean
flutter pub get
flutter build web --dart-define=env=stage
```

### Clear Derived Data (macOS/iOS)

```bash
rm -rf ~/Library/Developer/Xcode/DerivedData/
```

## Platform Specific Issues

### Android

| Issue | Solution |
|-------|---------|
| Gradle sync failed | `cd android && ./gradlew clean` then rebuild |
| minSdkVersion error | Check `android/app/build.gradle` minSdkVersion |
| Multidex error | Enable multidex in `build.gradle` |
| Keystore missing | Generate or locate the signing keystore |
| APK too large | Enable `--obfuscate` and ProGuard rules |

### iOS

| Issue | Solution |
|-------|---------|
| CocoaPods error | `cd ios && pod install --repo-update` |
| Signing error | Configure signing in Xcode |
| Bitcode error | Disable bitcode in Xcode build settings |
| Minimum iOS version | Check `ios/Podfile` platform version |

### Web

| Issue | Solution |
|-------|---------|
| CORS errors | Configure backend CORS for web origin |
| Camera not working | Ensure HTTPS (required for web camera) |
| Local storage issues | Check browser storage permissions |
| Alice not available | Alice HTTP inspector is disabled on web |

## Related Documents

- [Local Setup](./Local%20Setup.md) — Initial setup instructions
- [Configuration](./Configuration.md) — Build and environment configuration
- [Error Handling](./Error%20Handling.md) — Application error handling
