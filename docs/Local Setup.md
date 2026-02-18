<!-- Document Information -->
<!-- Generated: 2026-02-18 -->
<!-- Version: 6.0.0+83 -->
<!-- Commit: 9ea0c658 -->

# Local Setup

## Table of Contents

- [Prerequisites](#prerequisites)
- [Flutter SDK Setup](#flutter-sdk-setup)
- [Clone and Install](#clone-and-install)
- [Environment Configuration](#environment-configuration)
- [Build and Run Commands](#build-and-run-commands)
- [Code Generation](#code-generation)
- [IDE Setup](#ide-setup)
- [Common Setup Issues](#common-setup-issues)
- [Dependency Management](#dependency-management)
- [Related Documents](#related-documents)

## Prerequisites

| Requirement | Version | Notes |
|-------------|---------|-------|
| Flutter SDK | >=3.4.3 | Dart SDK included |
| Dart SDK | >=3.4.3 <4.0.0 | Bundled with Flutter |
| Android Studio | Latest | For Android builds and emulators |
| Xcode | Latest | For iOS builds (macOS only) |
| Git | Latest | For repository and package dependencies |
| Java/JDK | 17+ | Required for Android builds |

### Platform-Specific Requirements

| Platform | Requirements |
|----------|-------------|
| Android | Android SDK, build-tools, platform-tools |
| iOS | Xcode, CocoaPods, Apple Developer account |
| Web | Chrome browser |

## Flutter SDK Setup

```bash
# Verify Flutter installation
flutter doctor

# Verify SDK version meets requirement (>=3.4.3)
flutter --version

# If using FVM (Flutter Version Management)
fvm install 3.4.3
fvm use 3.4.3
```

## Clone and Install

```bash
# Clone the repository
git clone <repository-url> flutter_trc
cd flutter_trc

# Install dependencies
flutter pub get

# Verify the project builds
flutter analyze
```

### Shared Package Dependencies

The project depends on two internal git packages. These are resolved automatically via `pubspec.yaml`:

| Package Source | Repository | Version |
|---------------|-----------|---------|
| flutter_packages | Git dependency | v2.0.15 |
| flutter_admin_ui | Git dependency | v2.3.0 |

If you need to work with local versions of these packages, update the `pubspec.yaml` path references:

```yaml
# For local development (uncomment and adjust paths)
dependency_overrides:
  core_widgets:
    path: ../flutter_admin_ui/core_widgets
  components:
    path: ../flutter_admin_ui/components
```

## Environment Configuration

### Available Environments

| Environment | `--dart-define` value | API URL | Purpose |
|-------------|----------------------|---------|---------|
| Test | `env=prodTest` | api.cashify.in | Production test |
| Stage | `env=stage` | api.stage.cashify.in | Development/staging |
| Beta | `env=beta` | api.beta.cashify.in | Pre-production testing |
| Production | `env=prod` | api.cashify.in | Production |

### Default Environment

If no `--dart-define=env` is provided, the app defaults to `prod` (from `String.fromEnvironment('env', defaultValue: 'prod')`). For development, always specify `stage`:

```bash
flutter run --dart-define=env=stage
```

## Build and Run Commands

### Debug (Development)

```bash
# Stage (recommended for development)
flutter run --dart-define=env=stage

# Beta
flutter run --dart-define=env=beta

# Production test
flutter run --dart-define=env=prodTest
```

### Release APK

```bash
# Stage APK
flutter build apk --dart-define=env=stage --flavor stage --obfuscate --split-debug-info=mappings

# Beta APK
flutter build apk --dart-define=env=beta --flavor beta --obfuscate --split-debug-info=mappings

# Production APK
flutter build apk --dart-define=env=prod --flavor prod --obfuscate --split-debug-info=mappings
```

### Release App Bundle (AAB)

```bash
# Production AAB (for Play Store)
flutter build appbundle --dart-define=env=prod --flavor prod --obfuscate --split-debug-info=mappings
```

### Web

```bash
# Stage web
flutter run -d chrome --dart-define=env=stage

# Build web
flutter build web --dart-define=env=stage
```

### iOS

```bash
# Stage iOS
flutter run --dart-define=env=stage

# Production IPA
flutter build ipa --dart-define=env=prod --flavor prod --obfuscate --split-debug-info=mappings
```

### Using Build Scripts

```bash
# Main build script (interactive)
./scripts/flutter_build.sh

# Version update
./scripts/version_update.sh

# Localization generation
./scripts/localize.sh

# Clean rebuild
./scripts/rebuild.sh
```

## Code Generation

### JSON Serialization

Run `build_runner` to generate `.g.dart` files for `@JsonSerializable()` classes:

```bash
# Build once
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (regenerates on file changes)
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Localization

Generate localization files from ARB sources:

```bash
flutter pub run intl_utils:generate
```

ARB source files: `lib/src/l10n/core/intl_en.arb`, `lib/src/l10n/core/intl_hi.arb`

## IDE Setup

### Cursor IDE

The project includes Cursor rules in `.cursor/rules/` for AI-assisted development:

| Rule File | Purpose |
|-----------|---------|
| `api_endpoint_conventions.mdc` | API endpoint naming and parameter patterns |
| `flutter_style_guidelines.mdc` | Dart/Flutter code style |
| `iterate_to_cshapilist_migration.mdc` | Migration guide for list patterns |
| `qc_module_structure.mdc` | QC module folder structure |
| `qc_service_patterns.mdc` | Service class patterns |
| `repo_context.mdc` | Repository context and key locations |
| `stream_api_pattern.mdc` | Stream-based API patterns |

### VS Code / Android Studio

Recommended extensions:
- Dart
- Flutter
- Flutter Widget Snippets
- Dart Data Class Generator

## Common Setup Issues

### 1. Dependency Resolution Failures

**Problem:** `flutter pub get` fails on git dependencies.

**Solution:**
```bash
# Clear pub cache
flutter pub cache repair

# Remove lock file and retry
rm pubspec.lock
flutter pub get
```

### 2. Build Runner Conflicts

**Problem:** `build_runner` fails with conflicting outputs.

**Solution:**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Missing Flavor Configuration

**Problem:** Build fails with "Flavor not found" error.

**Solution:** Ensure Android `build.gradle` has flavor definitions for stage, beta, and prod. Check `android/app/build.gradle` for `productFlavors` block.

### 4. iOS Pod Install Failures

**Problem:** iOS build fails on CocoaPods.

**Solution:**
```bash
cd ios
pod deintegrate
pod install --repo-update
cd ..
flutter clean
flutter pub get
```

### 5. Environment Not Set

**Problem:** App connects to wrong API.

**Solution:** Always include `--dart-define=env=stage` in run commands. Default is `prod`.

### 6. Dart SDK Version Mismatch

**Problem:** Analysis errors due to SDK version.

**Solution:**
```bash
flutter doctor
# Ensure Flutter >= 3.4.3
flutter upgrade
```

### 7. Firebase Configuration Missing

**Problem:** Firebase initialization fails.

**Solution:** Ensure `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are in the correct locations for each flavor.

### 8. Code Generation Out of Date

**Problem:** Missing `.g.dart` files or serialization errors.

**Solution:**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Dependency Management

### Adding New Dependencies

```bash
# Add pub dependency
flutter pub add package_name

# Add dev dependency
flutter pub add --dev package_name
```

### Updating Dependencies

```bash
# Update all dependencies
flutter pub upgrade

# Update specific package
flutter pub upgrade package_name
```

### Shared Package Updates

When shared packages (flutter_packages, flutter_admin_ui) are updated:

1. Update the version/ref in `pubspec.yaml`
2. Run `flutter pub get`
3. Test thoroughly — shared packages affect all modules

## Related Documents

- [Configuration](./Configuration.md) — Detailed build and environment configuration
- [Architecture](./Architecture.md) — Project structure and dependencies
- [Troubleshooting](./Troubleshooting.md) — Common issues and solutions
