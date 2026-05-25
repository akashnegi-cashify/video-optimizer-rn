# Plan — host FFmpeg binaries via library's GitHub Releases + postinstall script

> This is a deferred-implementation plan. Nothing has been built yet. Pick this up when you're ready
> to make the library easier for consumers to install.

---

## TL;DR

When someone runs `yarn add @cashify/video-optimizer-rn`, a postinstall script automatically
downloads the FFmpeg-kit native binaries from a **GitHub Release on this same library's repo**,
drops them into the consumer's `android/` and `ios/` directories, and verifies SHA-256 checksums.
This removes ~80 % of the manual setup work consumers currently have to do.

Same GitHub repo as the library code. No separate binaries repo.

---

## Context — why this exists

The library is finished and Android-verified. But the FFmpeg-kit native binaries that the library
depends on are no longer hosted upstream:

- `com.arthenica:ffmpeg-kit-full-gpl:6.0-2.LTS` on Maven Central → **404** (Arthenica archived
  their repos in June 2025).
- `github.com/arthenica/ffmpeg-kit/releases/download/v6.0.LTS/ffmpeg-kit-full-gpl-6.0.LTS-ios-framework.zip`
  → **404** for the same reason.

We worked around this for the example app by:
1. Copying the AAR into `example/android/local-maven/` and overriding `dependencyResolutionManagement`.
2. Downloading the iOS framework ZIP from a community mirror (sk3llo) and writing a local
   `ffmpeg-kit-ios-full-gpl.podspec` pointing at the extracted `.framework` directories.

A real consumer (`CashifyKiosk`, `CashifyAdserve`, future apps) would have to repeat the same
five-step workaround manually. That's friction, and depends on sk3llo's mirror staying up. This
plan removes that friction by making the library host the binaries itself.

---

## The fix in plain terms

**One repo. Source code in git, binaries as Release attachments.**

```
github.com/<your-org>/video-optimizer-rn       ← ONE repo
├── git: source code (cloned by anyone reading the lib)
│   ├── src/                                   the TypeScript lib
│   ├── scripts/                               NEW — postinstall logic
│   ├── package.json                           NEW — postinstall hook registered
│   └── ... (small text files only)
│
└── Releases tab:                              built-in GitHub feature
    └── Tag: binaries-v1
        ├── ffmpeg-kit-full-gpl-6.0-2.LTS.aar          (73 MB Android)
        ├── ffmpeg-kit-full-gpl-6.0-2.LTS.pom          (tiny XML)
        └── ffmpeg-kit-full-gpl-6.0.LTS-ios-framework.zip  (130 MB iOS)
```

The **npm package** (what `yarn add` downloads) is ~300 KB — TypeScript + scripts, **no binaries
inside**. The binaries are fetched at install-time by the postinstall script, from the URLs above.

---

## Files we'll add to the library

```
@cashify/video-optimizer-rn/
├── scripts/
│   ├── postinstall.js              # entry point; called automatically after `yarn add`
│   ├── download-binaries.js        # streams from GitHub Releases, verifies SHA-256
│   ├── install-android.js          # copies AAR + POM, patches settings.gradle
│   ├── install-ios.js              # unzips framework, drops local podspec
│   └── binary-versions.json        # source of truth for URLs + checksums
├── src/                            # unchanged
└── package.json                    # adds: scripts.postinstall + "scripts" in `files` array
```

### `scripts/postinstall.js`

Entry point. Runs automatically because of the `"postinstall": "node scripts/postinstall.js"`
entry in `package.json`. Responsibilities:

- Skip early if env var `VIDEO_OPTIMIZER_RN_SKIP_POSTINSTALL=1` is set (CI escape hatch).
- Skip if running inside the library's own repo (detect by checking for `src/FfmpegOptimize.ts`).
- Walk up from `node_modules/@cashify/video-optimizer-rn/` to find the consumer's project root.
- Call `install-android.js` and `install-ios.js`.
- Print a clear summary of what was done and any manual steps the user still has to do (Podfile
  entry, smart-exception gradle deps).

### `scripts/download-binaries.js`

Reusable utility. Used by both install scripts. Streams files from a URL using Node's built-in
`https` module (no external dependencies — postinstall scripts can't safely depend on packages that
themselves have postinstall scripts).

Caches downloads under `~/.cache/cashify-video-optimizer-rn/<sha256>/` so multiple projects on the
same machine don't re-download.

Verifies SHA-256 after download. Aborts with a clear error if the checksum doesn't match the value
in `binary-versions.json`.

### `scripts/install-android.js`

1. Check if `<consumer>/android/local-maven/com/arthenica/ffmpeg-kit-full-gpl/6.0-2.LTS/ffmpeg-kit-full-gpl-6.0-2.LTS.aar`
   already exists. If yes, log "Android binaries already installed, skipping" and exit.
2. Download the AAR via `download-binaries.js`. Write it to that path.
3. Download the POM the same way.
4. Read `<consumer>/android/settings.gradle`. If it doesn't already contain the string
   `local-maven`, print a copy-pasteable snippet for the user to add (we **don't** edit their
   settings.gradle automatically — too risky).

### `scripts/install-ios.js`

1. Check if `<consumer>/ios/local-frameworks/ffmpegkit.framework/` already exists. Skip if yes.
2. Download the iOS framework ZIP.
3. Extract it into `<consumer>/ios/local-frameworks/` using Node's built-in zip handling
   (`node:zlib` + a small streaming unzip, or shell out to `/usr/bin/unzip`).
4. Copy the local podspec we already wrote at
   `example/ios/local-frameworks/ffmpeg-kit-ios-full-gpl.podspec` into the new location, so the
   consumer's Podfile can reference it via `pod 'ffmpeg-kit-ios-full-gpl', :path => 'local-frameworks'`.
5. Print a copy-pasteable Podfile snippet.

### `scripts/binary-versions.json`

Single source of truth for which binaries to fetch. Loaded by `download-binaries.js` at runtime.

```json
{
  "version": "6.0-2.LTS",
  "android": {
    "aar": {
      "url": "https://github.com/<your-org>/video-optimizer-rn/releases/download/binaries-v1/ffmpeg-kit-full-gpl-6.0-2.LTS.aar",
      "sha256": "<filled in after first upload>"
    },
    "pom": {
      "url": "https://github.com/<your-org>/video-optimizer-rn/releases/download/binaries-v1/ffmpeg-kit-full-gpl-6.0-2.LTS.pom",
      "sha256": "<filled in after first upload>"
    }
  },
  "ios": {
    "frameworkZip": {
      "url": "https://github.com/<your-org>/video-optimizer-rn/releases/download/binaries-v1/ffmpeg-kit-full-gpl-6.0.LTS-ios-framework.zip",
      "sha256": "<filled in after first upload>"
    }
  }
}
```

### `package.json` changes

```json
{
  "scripts": {
    "build": "tsc",
    "test": "jest",
    "lint": "eslint src --ext .ts,.tsx",
    "postinstall": "node scripts/postinstall.js",
    "prepublishOnly": "npm run clean && npm run build && npm test"
  },
  "files": [
    "dist",
    "src",
    "scripts",
    "README.md",
    "LICENSE",
    "CHANGELOG.md"
  ]
}
```

---

## What you'll do (one-time setup steps)

When you're ready to execute this plan, here's what only you can do:

1. **Confirm or create the library's GitHub repo.** Likely
   `github.com/<your-team-org>/video-optimizer-rn`. Tell me the URL.
2. **Push the library code to it** (if it's not already there).
3. **On that repo's GitHub web UI, create a Release:**
   - Click "Releases" → "Draft a new release"
   - Tag name: `binaries-v1` (do not use the library's own version tags; binaries version
     independently)
   - Upload the three files from this Mac:
     - `example/android/local-maven/com/arthenica/ffmpeg-kit-full-gpl/6.0-2.LTS/ffmpeg-kit-full-gpl-6.0-2.LTS.aar`
     - `example/android/local-maven/com/arthenica/ffmpeg-kit-full-gpl/6.0-2.LTS/ffmpeg-kit-full-gpl-6.0-2.LTS.pom`
     - `example/ios/local-frameworks/ffmpeg-kit-full-gpl-6.0.LTS-ios-framework.zip`
   - Click "Publish release"
4. **Get the SHA-256 of each uploaded file.** Easiest from the same Mac before uploading:

   ```bash
   cd /Users/akashnegi/workspace/react-native/video-optimizer-rn
   shasum -a 256 example/android/local-maven/com/arthenica/ffmpeg-kit-full-gpl/6.0-2.LTS/ffmpeg-kit-full-gpl-6.0-2.LTS.aar
   shasum -a 256 example/android/local-maven/com/arthenica/ffmpeg-kit-full-gpl/6.0-2.LTS/ffmpeg-kit-full-gpl-6.0-2.LTS.pom
   shasum -a 256 example/ios/local-frameworks/ffmpeg-kit-full-gpl-6.0.LTS-ios-framework.zip
   ```

5. **Send me the repo URL + the 3 SHA-256 values.** I'll write all the JS, hard-code those values
   into `binary-versions.json`, and run end-to-end verification.

---

## What I'll do (when you say go)

1. Write all four files in `scripts/`.
2. Update `package.json` (`postinstall` hook + `files` entry for `scripts/`).
3. Simplify the README's "Known issue" section — it'll go from "do these 5 things" to
   "`yarn add` does most of it; here are the 2 small bits left."
4. Verification:
   - Run the unit tests (should still pass — these scripts don't touch the library).
   - Create a fresh test RN app, run `yarn add @cashify/video-optimizer-rn`, confirm the
     postinstall downloads + drops binaries in the right places.
   - Confirm `yarn install` a second time skips the download (cache hit).
   - Confirm `VIDEO_OPTIMIZER_RN_SKIP_POSTINSTALL=1 yarn install` skips entirely (CI escape).
   - Build and run the test RN app on Android. Should work end-to-end.

---

## What we explicitly chose against

| Approach | Why we rejected it |
|---|---|
| Put binaries directly in git (under `binaries/`) | Every `git clone` would pull 200 MB even for people only reading the source. GitHub flags repos over 1 GB. We'd need Git LFS to make it tolerable, but `git lfs` isn't installed on this Mac. |
| Bundle binaries inside the npm package | 200 MB npm package. Slow installs. Also still requires postinstall logic to copy them into `android/` + `ios/`, so we save nothing. |
| Use a separate GitHub repo just for binaries | More to manage. No upside — Releases are designed for exactly this on the same repo. |
| Use a community fork that self-hosts binaries (e.g. `@wokcito/ffmpeg-kit-react-native`) | The fork I spot-checked had no GitHub releases. Even if a good fork exists, it's a dependency on someone else's continued maintenance. Hosting ourselves means we control availability. |
| Just document the manual steps and don't automate | What we have now. Friction every time a consumer onboards. |

---

## Trade-offs to be aware of

### Postinstall scripts can be disabled

Some orgs run `yarn install --ignore-scripts` for security. The fix would silently do nothing in
that case. **Mitigation:** the script also works as a manual invocation —
`npx video-optimizer-rn install-binaries` — so a user with `--ignore-scripts` can run it once by
hand. Document this in README.

### GitHub rate limits

Anonymous GitHub Release downloads are limited to ~60/hour from the same IP. Fine for normal use,
could bite CI runners that all share an IP. **Mitigation:** the on-disk cache means each CI runner
downloads each binary version at most once.

### We become a redistributor of GPL software

By hosting the FFmpeg-kit binaries on our GitHub Release, we take on GPLv3 redistribution
responsibility. **Mitigation:** the library is already GPL-3.0; our LICENSE file already says so;
the Release description will credit Arthenica + link the upstream source.

### Auto-editing consumer's gradle/podfile

Decided NOT to do this. The scripts print copy-paste snippets instead. Rationale: those files
often have user customizations and corner cases (multi-flavor builds, custom signing configs);
silent auto-editing is a footgun. The user pastes ~3 lines. Acceptable.

### iOS framework has no arm64-simulator slice

The 6.0.LTS framework was built before Apple Silicon Macs were widespread. It works on real iPhones
and x86_64 simulators, **not** on arm64 simulators (Apple Silicon Mac default). The local podspec
already includes `EXCLUDED_ARCHS[sdk=iphonesimulator*] = arm64` to suppress the build error, but the
practical effect is **iOS testing requires a real device** until someone produces a new framework
with the arm64-simulator slice. This is independent of this plan — would be the same if we did
nothing.

---

## Open questions (resolve before starting)

1. **GitHub repo URL** for the library — needed to hardcode the Release download URLs.
2. **Release tag scheme** — recommendation: `binaries-v1` for the binaries (stays stable across many
   library versions). Library version tags (`v0.1.0`, `v0.2.0`, …) are separate. Alternative: one
   binary release per library version (uniform, but means re-uploading 130 MB for every library
   patch).

---

## Estimated time

- My implementation work: **~2 hours**, mostly testing edge cases of the postinstall flow on a
  fresh RN app.
- Your one-time GitHub upload + SHA-256: **~15 minutes**.
- Per-consumer setup after this lands: **~3 minutes** instead of the current ~30.

---

## Out of scope (not in this plan)

- iOS simulator support on Apple Silicon Macs (would need a different FFmpeg build that includes
  arm64-simulator).
- Auto-patching `Podfile` and `app/build.gradle`. Too risky to do silently. README snippets only.
- Switching to a maintained `xcframework` build of FFmpeg if/when one becomes available — that's
  a binary-version bump (new entry in `binary-versions.json`), not a redesign.
- Monorepo edge cases (Yarn Berry workspaces, nohoist setups). v0.1 assumes standard hoisting.
