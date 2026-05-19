#!/usr/bin/env bash
# =============================================================================
# patch_pub_cache_manifests.sh
#
# AGP 8 forbids `package="..."` in plugin AndroidManifest.xml files; the namespace
# must come from build.gradle instead. Several `@reglobe/flutter_plugins` git-deps
# (text_recognizer, face_detector, csh_jus_pay, csh_payment_gateway, csh_razor_pay,
# udid, device_cpu_detail) still ship the old layout.
#
# We can't edit the git deps in-place via a build.gradle hook (too late in the
# pipeline), so this script scrubs the `package="..."` attribute from every
# flutter_plugins manifest in the user's pub-cache.
#
# Idempotent — safe to run repeatedly. Must be re-run after every `flutter pub
# cache repair` / `flutter pub get` that pulls a new git SHA.
# =============================================================================

set -euo pipefail

PUB_CACHE_GIT="${PUB_CACHE:-$HOME/.pub-cache}/git"

if [[ ! -d "$PUB_CACHE_GIT" ]]; then
  echo "[patch] pub-cache/git not found at $PUB_CACHE_GIT — nothing to patch."
  exit 0
fi

patched=0
for manifest in "$PUB_CACHE_GIT"/flutter_plugins-*/*/android/src/main/AndroidManifest.xml; do
  [[ -f "$manifest" ]] || continue
  if grep -qE 'package="[^"]+"' "$manifest"; then
    # In-place strip of the package="..." attribute on the <manifest> opening tag.
    # macOS sed wants `-i ''`; GNU sed wants `-i`. Detect.
    if sed --version >/dev/null 2>&1; then
      sed -i -E 's/[[:space:]]*package="[^"]+"//' "$manifest"
    else
      sed -i '' -E 's/[[:space:]]*package="[^"]+"//' "$manifest"
    fi
    patched=$((patched + 1))
    echo "[patch] stripped package= from: ${manifest#$HOME/}"
  fi
done

echo "[patch] done — $patched manifest(s) patched."
