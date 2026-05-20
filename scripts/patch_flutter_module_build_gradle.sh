#!/usr/bin/env bash
# =============================================================================
# patch_flutter_module_build_gradle.sh
#
# Idempotently injects an AGP 8 namespace fallback into
# flutter_module/.android/build.gradle so older Flutter plugins (e.g.
# text_recognizer, face_detector, etc. — see Phase 9 G1 in the migration plan)
# that don't declare `namespace` in their own build.gradle still build.
#
# WHY this script exists:
# `flutter pub get` regenerates flutter_module/.android/build.gradle whenever
# it feels like it (notably after adding new git-based dependencies). Any
# hand-edited patch is silently wiped. This script restores the patch and is
# idempotent — safe to run on every CI/dev build, before `flutter build aar`.
# =============================================================================

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="$REPO_ROOT/flutter_module/.android/build.gradle"
MARKER="// __G1_NAMESPACE_PATCH__"

if [[ ! -f "$TARGET" ]]; then
  echo "[g1-patch] $TARGET not found — run \`cd flutter_module && flutter pub get\` first." >&2
  exit 1
fi

if grep -q "$MARKER" "$TARGET"; then
  echo "[g1-patch] already patched, skipping."
  exit 0
fi

# Inject the subprojects { afterEvaluate { ... } } block right after the
# closing brace of the existing `allprojects { ... }` block. Uses python3 for
# reliable multiline regex (sed is too platform-dependent for this).
python3 - "$TARGET" <<'PY'
import re, sys, pathlib

path = pathlib.Path(sys.argv[1])
src = path.read_text()

patch = """
// __G1_NAMESPACE_PATCH__
// Idempotent: provides a namespace fallback for older Flutter plugins that
// don't declare `namespace` in their own build.gradle (AGP 8 requirement).
// Managed by scripts/patch_flutter_module_build_gradle.sh — DO NOT REMOVE.
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
"""

# Find the start of `allprojects {` and walk forward, counting braces, to find
# its matching closing brace. Handles any level of nesting.
m = re.search(r'allprojects\s*\{', src)
if not m:
    print("[g1-patch] ERROR: could not locate `allprojects {` in build.gradle", file=sys.stderr)
    sys.exit(2)

i = m.end()
depth = 1
while i < len(src) and depth > 0:
    ch = src[i]
    if ch == '{':
        depth += 1
    elif ch == '}':
        depth -= 1
    i += 1

if depth != 0:
    print("[g1-patch] ERROR: unmatched braces while scanning `allprojects` block", file=sys.stderr)
    sys.exit(3)

# i is now right after the matching closing brace of allprojects { ... }.
new = src[:i] + "\n" + patch + src[i:]
path.write_text(new)
print(f"[g1-patch] injected namespace fallback block into {path}")
PY
