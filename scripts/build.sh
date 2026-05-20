#!/usr/bin/env bash
# =============================================================================
# Cashify-OPS — Combined RN + Flutter build pipeline.
#
# Usage:
#   FLAVOR=stage PLATFORM=android ./scripts/build.sh
#   FLAVOR=prod  PLATFORM=ios     ./scripts/build.sh
#
# Required env (CI):
#   FLAVOR    — prod | beta | stage
#   PLATFORM  — android | ios
# Optional:
#   BUILD_MODE — release (default) | debug
#   SKIP_NPM   — 1 to skip `yarn install`
#   SKIP_PUB   — 1 to skip `flutter pub get`
# =============================================================================

set -euo pipefail

FLAVOR="${FLAVOR:-prod}"
PLATFORM="${PLATFORM:-android}"
BUILD_MODE="${BUILD_MODE:-release}"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

echo "============================================"
echo " Cashify-OPS build"
echo "   FLAVOR:    $FLAVOR"
echo "   PLATFORM:  $PLATFORM"
echo "   BUILD_MODE: $BUILD_MODE"
echo "============================================"

# 1. JS deps
if [[ "${SKIP_NPM:-0}" != "1" ]]; then
  yarn install --immutable
fi

# 2. Flutter module deps + AAR / framework
if [[ "${SKIP_PUB:-0}" != "1" ]]; then
  (cd flutter_module && flutter pub get)
fi

# 2a. Patch git-pinned plugin manifests for AGP 8 compatibility (G2).
# Idempotent — only edits files that still have the old `package="..."` attribute.
"$REPO_ROOT/scripts/patch_pub_cache_manifests.sh"

# 2b. Re-inject the G1 namespace fallback into flutter_module/.android/build.gradle.
# `flutter pub get` regenerates that file when git deps change, wiping the patch.
# Idempotent — skipped if the marker is already present.
"$REPO_ROOT/scripts/patch_flutter_module_build_gradle.sh"

if [[ "$PLATFORM" == "android" ]]; then
  # Pre-built AAR approach: build the Flutter AAR per-flavor.
  # For release host builds we only need the release AAR variant (faster build).
  # For debug host builds we need the debug AAR too (Dart VM Service + hot reload).
  if [[ "$BUILD_MODE" == "release" ]]; then
    AAR_VARIANT_FLAGS="--no-debug --no-profile"
  else
    AAR_VARIANT_FLAGS="--no-profile"
  fi
  (cd flutter_module && flutter build aar $AAR_VARIANT_FLAGS --dart-define=env="$FLAVOR")
  "$REPO_ROOT/scripts/fix_aar_artifacts.sh"

  FLAVOR_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${FLAVOR:0:1})${FLAVOR:1}"
  BUILD_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${BUILD_MODE:0:1})${BUILD_MODE:1}"

  (cd android && ./gradlew "assemble${FLAVOR_CAP}${BUILD_CAP}")
  echo "APK:"
  find android/app/build/outputs/apk/${FLAVOR}/${BUILD_MODE} -name "*.apk" 2>/dev/null | head -5

elif [[ "$PLATFORM" == "ios" ]]; then
  (cd flutter_module && flutter build ios-framework --no-debug --no-profile \
    --output="$REPO_ROOT/flutter_module/build/ios-framework")

  (cd ios && pod install --repo-update)

  # Scheme + configuration combinations are wired in Xcode (xcconfigs).
  SCHEME="Cashify Ops $(tr '[:lower:]' '[:upper:]' <<< ${FLAVOR:0:1})${FLAVOR:1}"
  CONFIG="$(tr '[:lower:]' '[:upper:]' <<< ${BUILD_MODE:0:1})${BUILD_MODE:1}"

  xcodebuild -workspace ios/CashifyOps.xcworkspace \
    -scheme "$SCHEME" \
    -configuration "$CONFIG" \
    -destination 'generic/platform=iOS' \
    -archivePath "build/ios/${FLAVOR}-${BUILD_MODE}.xcarchive" \
    archive
  echo "Archive: build/ios/${FLAVOR}-${BUILD_MODE}.xcarchive"

else
  echo "Unknown PLATFORM: $PLATFORM (expected android | ios)" >&2
  exit 1
fi

echo "============================================"
echo " Build complete: $FLAVOR / $PLATFORM / $BUILD_MODE"
echo "============================================"
