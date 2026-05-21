#!/usr/bin/env bash
# Write a placeholder react-native.config.js into node_modules/@reglobe/lego-core/
# so @react-native-community/cli skips platform discovery for this package.
#
# Why: lego-core ships a stray android/ folder that isn't a valid RN native
# module. Without this file, autolinking throws while parsing its build.gradle,
# which blocks `pod install` and Android autolinking regeneration.
#
# This runs as a yarn postinstall hook so the placeholder is restored on every
# fresh install.

set -euo pipefail

TARGET="node_modules/@reglobe/lego-core/react-native.config.js"

if [ ! -d "node_modules/@reglobe/lego-core" ]; then
  # lego-core not installed (e.g. partial install failure) — nothing to patch.
  exit 0
fi

cat > "$TARGET" <<'EOF'
// Placeholder written by scripts/patch_lego_core_autolink.sh (yarn postinstall).
// lego-core ships a stray android/ folder that isn't an RN native module.
// This file tells @react-native-community/cli to skip platform discovery for
// this package. Without it, autolinking throws while parsing the (invalid for
// RN purposes) android/build.gradle.
module.exports = {
  dependency: {
    platforms: {
      android: null,
      ios: null,
    },
  },
};
EOF

echo "patched: $TARGET"
