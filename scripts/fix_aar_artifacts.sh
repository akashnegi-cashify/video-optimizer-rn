#!/usr/bin/env bash
# =============================================================================
# fix_aar_artifacts.sh
#
# Post-processes the output of `flutter build aar` to work around two known
# plugin packaging issues that break cross-project AAR consumption:
#
#   1. flutter_tesseract_ocr — its generated POM contains a flat-file dependency
#      with no <groupId>, which AGP refuses to parse. We strip that bad entry.
#      (The plugin is only listed transitively by imei_serial_reader; no Dart
#      code actually calls into it, so dropping the dep is safe.)
#
#   2. ffmpeg_kit_flutter_android — the plugin's `setupDependencies` task
#      downloads a 6.0 ffmpeg AAR to its own build/ dir as a plugin-local
#      maven artifact, but that local repo never gets published outside the
#      plugin's build sandbox. We copy the resulting AAR + POM into our shared
#      maven repo so the host gradle can resolve `com.arthenica.ffmpegkit:flutter:6.0`.
#
# Must run AFTER `flutter build aar` and BEFORE `./gradlew assemble*`.
# Idempotent.
# =============================================================================

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AAR_REPO="$REPO_ROOT/flutter_module/build/host/outputs/repo"
PUB_CACHE="${PUB_CACHE:-$HOME/.pub-cache}"

if [[ ! -d "$AAR_REPO" ]]; then
  echo "[fix-aar] $AAR_REPO not found — run \`cd flutter_module && flutter build aar\` first."
  exit 1
fi

# -----------------------------------------------------------------------------
# 1. For each Flutter build variant (debug | profile | release):
#    a. Strip the malformed flat-file <dependency> block from
#       flutter_tesseract_ocr_<variant>-1.0.pom (no <groupId> → AGP rejects).
#    b. Delete flutter_tesseract_ocr_<variant>-1.0.module (Gradle Module Metadata).
#       Gradle prefers the .module over the POM, and the .module has the same
#       bad dependency entry (`"group": null` for tesseract<variant>-<variant>).
#       Removing it forces Gradle to fall back to the patched POM.
#
# Both are needed because Gradle reads the .module file first when present and
# the POM marker `do_not_remove: published-with-gradle-metadata` tells Gradle
# to prefer the .module. We can't safely edit the .module (Gradle expects
# specific checksums); deleting it is cleaner.
# -----------------------------------------------------------------------------
for variant in release debug profile; do
  TESS_DIR="$AAR_REPO/io/paratoner/flutter_tesseract_ocr/flutter_tesseract_ocr_${variant}/1.0"
  TESS_POM="$TESS_DIR/flutter_tesseract_ocr_${variant}-1.0.pom"
  TESS_MODULE="$TESS_DIR/flutter_tesseract_ocr_${variant}-1.0.module"

  if [[ -f "$TESS_POM" ]]; then
    if grep -q "<artifactId>tesseract4android-${variant}</artifactId>" "$TESS_POM" 2>/dev/null \
       || grep -q "<artifactId>tesseract4android-release</artifactId>" "$TESS_POM" 2>/dev/null; then
      python3 - "$TESS_POM" <<'PY'
import re, sys, pathlib
p = pathlib.Path(sys.argv[1])
src = p.read_text()
# Strip any <dependency>…</dependency> block whose <artifactId> starts with
# tesseract4android- (no <groupId> → AGP rejects).
cleaned = re.sub(
    r'\n?\s*<dependency>\s*'
    r'<artifactId>tesseract4android-[^<]+</artifactId>.*?</dependency>',
    '',
    src,
    flags=re.DOTALL,
)
p.write_text(cleaned)
print(f"[fix-aar] stripped malformed tesseract4android-* <dependency> from {p.name}")
PY
    fi
  fi

  if [[ -f "$TESS_MODULE" ]]; then
    rm -f "$TESS_MODULE" "$TESS_MODULE".md5 "$TESS_MODULE".sha1 "$TESS_MODULE".sha256 "$TESS_MODULE".sha512
    echo "[fix-aar] deleted flutter_tesseract_ocr_${variant}-1.0.module (forces POM fallback)."
  fi
done

# -----------------------------------------------------------------------------
# 2. Copy the plugin-local ffmpeg-kit maven artifacts into our shared repo.
#    Source layout (produced by ffmpeg_kit_flutter_android plugin):
#      $PUB_CACHE/hosted/pub.dev/ffmpeg_kit_flutter_android-1.2.0/android/build/
#        com/arthenica/ffmpegkit/flutter/6.0/{flutter-6.0.aar, flutter-6.0.pom}
#    Destination (our shared repo, picked up by android/build.gradle maven block):
#      $AAR_REPO/com/arthenica/ffmpegkit/flutter/6.0/
# -----------------------------------------------------------------------------
FFMPEG_PLUGIN_BUILD="$PUB_CACHE/hosted/pub.dev/ffmpeg_kit_flutter_android-1.2.0/android/build/com/arthenica/ffmpegkit/flutter/6.0"
FFMPEG_DEST="$AAR_REPO/com/arthenica/ffmpegkit/flutter/6.0"

if [[ -f "$FFMPEG_PLUGIN_BUILD/flutter-6.0.aar" && -f "$FFMPEG_PLUGIN_BUILD/flutter-6.0.pom" ]]; then
  mkdir -p "$FFMPEG_DEST"
  cp -f "$FFMPEG_PLUGIN_BUILD/flutter-6.0.aar" "$FFMPEG_DEST/flutter-6.0.aar"
  cp -f "$FFMPEG_PLUGIN_BUILD/flutter-6.0.pom" "$FFMPEG_DEST/flutter-6.0.pom"
  echo "[fix-aar] copied com.arthenica.ffmpegkit:flutter:6.0 (aar + pom) into local repo."
else
  echo "[fix-aar] WARNING: $FFMPEG_PLUGIN_BUILD/flutter-6.0.{aar,pom} not found."
  echo "[fix-aar] Run \`cd flutter_module && flutter build aar\` again — the plugin's"
  echo "[fix-aar] setupDependencies task needs to publish these files first."
fi

echo "[fix-aar] done."
