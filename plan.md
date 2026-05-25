## Architecture

The package has **three logical layers**, the same as the Flutter package:

```
┌────────────────────────────────────────────────────────────────────┐
│  Layer 3: Consumer API (what apps use)                             │
│                                                                    │
│  • OptimizerController (singleton with primary + fallback)         │
│  • useVideoOptimizer() React hook (added; not in Flutter)          │
│  • VideoConfig / ImageConfig (config DTOs the consumer passes in)  │
└────────────────────────────────────────────────────────────────────┘
                              ▲
                              │ depends on
                              ▼
┌────────────────────────────────────────────────────────────────────┐
│  Layer 2: Strategy implementations                                 │
│                                                                    │
│  • FfmpegOptimize  implements AbstVideoOptimizer                   │
│  • FfmpegImageOptimizer  implements AbstImageOptimizer             │
│                                                                    │
│  These translate a VideoConfig/ImageConfig into FFmpeg args,       │
│  invoke the native bridge, and adapt the bridge's per-session      │
│  callbacks into the consumer's onProgress/onError contract.        │
└────────────────────────────────────────────────────────────────────┘
                              ▲
                              │ depends on
                              ▼
┌────────────────────────────────────────────────────────────────────┐
│  Layer 1: Pure functions (no native deps, fully unit-testable)     │
│                                                                    │
│  • FfmpegCommand.createArguments(...)   → string[] (video)         │
│  • FfmpegCommand.getImageCommand(...)   → string  (image)          │
│  • VideoCodec / VideoPreset enums and fromString helpers           │
│  • withVideoConfigDefaults(partial)                                │
└────────────────────────────────────────────────────────────────────┘
                              ▲
                              │ (no deps below this point inside the package)
                              ▼
┌────────────────────────────────────────────────────────────────────┐
│  External native bridge (not owned by us)                          │
│                                                                    │
│  • ffmpeg-kit-react-native  (FFmpegKit.executeAsync, FFmpegKitConfig,│
│      ReturnCode, FFmpegSession, Statistics)                        │
│  • react-native-fs          (filesystem: stat, unlink, paths)      │
└────────────────────────────────────────────────────────────────────┘
```

Why three layers and not two:

- **Layer 1 is the porting-fidelity gate.** The FFmpeg command strings are the contract between the
  Flutter app and the RN app. If `FfmpegCommand.createArguments` produces the same bytes the Dart
  version produces, the rest of the package can be implementation-detail. We can unit test Layer 1
  in pure Jest without booting React Native.
- **Layer 2 isolates the native bridge.** Anything that touches `FFmpegKit.executeAsync` or
  `RNFS.*` lives here. If `ffmpeg-kit-react-native` is replaced by a fork (likely, given Arthenica's
  archival), the change is one file.
- **Layer 3 is the consumer-facing surface.** Two entry points: the Flutter-mirror classes
  (`OptimizerController`) for parity, and a `useVideoOptimizer` hook for React idiomatic use. Both
  delegate to Layer 2.

## Runtime Flow

End-to-end sequence for a single `optimizeVideo(...)` call (the most important code path):

```
Consumer code
   │
   │ const controller = getOptimizerController({ primary: new FfmpegOptimize() });
   │ await controller.init();
   │ await controller.optimizeVideo({ inputPath, outputPath, config, videoTimeMs });
   ▼
OptimizerController.optimizeVideo
   │
   │ try { await primary.optimizeVideo(...) }
   │ catch (e) { if (fallback) await fallback.optimizeVideo(...); else throw; }
   ▼
FfmpegOptimize.optimizeVideo
   │
   │ 1. args = FfmpegCommand.createArguments(config, in, out, videoTimeMs)  ← pure
   │ 2. config.onProgressStart?.(videoTimeMs)
   │ 3. await deleteFile(outputPath)  ← RNFS.unlink (idempotent)
   │ 4. inputSize = await RNFS.stat(inputPath)  ← for debug log
   │ 5. const cmd = args.map(shellQuote).join(' ')
   │ 6. return new Promise((resolve, reject) => {
   │      FFmpegKit.executeAsync(
   │        cmd,
   │        async session => {                  ← completion callback
   │          const rc = await session.getReturnCode();
   │          if (ReturnCode.isSuccess(rc))   { config.onProgressEnd?.();  resolve(); }
   │          else if (ReturnCode.isCancel(rc)) { config.onError?.('… cancelled'); reject(...); }
   │          else { const msg = '… failed …' + (await session.getFailStackTrace());
   │                 config.onError?.(msg); reject(new Error(msg)); }
   │        },
   │        log => debugLog(log.getMessage()),  ← log callback (per-session)
   │        stats => {                          ← statistics callback (per-session)
   │          if (videoTimeMs <= 0) return;
   │          const pct = clamp(Math.floor(stats.getTime() * 100 / videoTimeMs), 0, 100);
   │          config.onProgress?.(pct);
   │        },
   │      );
   │    });
   ▼
ffmpeg-kit-react-native bridge
   │
   │ Crosses JS → Native, runs FFmpeg command against the bundled binary,
   │ emits log + statistics events back into JS, then fires the completion callback.
   ▼
done — file at outputPath, or rejected promise with an error message
```

The image flow is identical but simpler (single string command, no statistics callback, no progress
%).

## Mapping: Flutter → React Native

| Flutter (Dart) — `ffmpeg_kit_flutter_new` | React Native (TS) — `ffmpeg-kit-react-native` | Notes |
| --- | --- | --- |
| `FFmpegKit.executeWithArguments(List<String>)` | `FFmpegKit.executeAsync(string)` + per-session callbacks | RN does not have a `Future`-returning variant; we wrap in a `Promise` |
| `FFmpegKitConfig.enableLogCallback(cb)` (global) | passed as 2nd arg to `executeAsync` (per-session) | RN scopes callbacks per session, avoiding the Flutter code's global-state race |
| `FFmpegKitConfig.enableStatisticsCallback(cb)` (global) | passed as 3rd arg to `executeAsync` (per-session) | same as above |
| `await session.getState()` | `await session.getState()` | same |
| `await session.getReturnCode()` | `await session.getReturnCode()` | same |
| `ReturnCode.isSuccess(rc)` / `isCancel(rc)` | same | same |
| `await session.getFailStackTrace()` | `await session.getFailStackTrace()` | same |
| `Logger.debug(...)` (from `core` package) | `console.debug` by default, with `setDebugLog()` injection | we drop the `core` dependency |
| `getTemporaryDirectory()` (path_provider) | `RNFS.CachesDirectoryPath` | RN uses cache dir instead of tmp; semantically equivalent on mobile |
| `File(path).lengthSync()` | `await RNFS.stat(path)` then `.size` | RN has no sync file ops; we await |
| `File(path).delete()` | `await RNFS.unlink(path)` | wrap in try/catch since "missing file" is OK |

## Anticipated Challenges

These are the issues likely to come up during implementation. Each has a planned mitigation.

### 1. Argument string fidelity (HIGH — single biggest risk)

**Problem.** The Flutter code uses `executeWithArguments(List<String>)` — an array — where each
element is a discrete arg passed to FFmpeg's `argv`. The RN API takes a single string and parses it
internally. That means a path containing spaces (`/sdcard/My Videos/clip.mp4`) breaks if we just
`array.join(' ')`. The Flutter version doesn't have this problem because args never need quoting.

The `drawtext` filter is also notoriously bracket-and-colon heavy:
`drawtext=text=%{pts\:localtime\:1716000000\:%Y-%m-%d %H-%M-%S}:x=20:y=20:…`. The space between
`%H-%M-%S` and the rest, plus the colons inside `%{…}`, are exactly the kind of thing a naïve string
join + native-side argv parser will misread.

**Mitigation.**
- A `shellQuote(arg: string): string` helper in `FfmpegCommand.ts` that:
  - returns the arg unchanged if it contains no whitespace, `'`, `"`, `\`, or `;`,
  - else wraps it in single quotes and escapes any inner single quotes.
- Apply `shellQuote` only to the **paths and the drawtext value**, not to the flag tokens (`-i`,
  `-c:v`, etc.) — because the FFmpeg-kit RN parser tolerates unquoted alphanumeric tokens.
- Add a `__tests__/FfmpegCommand.shellQuote.test.ts` with paths containing every problematic
  character. **Run the resulting command via the example app on a real device once before declaring
  this layer done** (Phase 6, cross-platform parity check).

### 2. Progress percentage calculation requires `videoTimeMs` upfront

**Problem.** The Flutter API requires the consumer to pass the input video's duration so the
statistics callback can compute %. If the consumer doesn't know the duration, progress reports get
`NaN%` or `Infinity%` (Dart) / `Infinity` (TS). The Flutter code guards by silently emitting wrong
numbers; we shouldn't.

**Mitigation.**
- Guard in `FfmpegOptimize`: if `videoTimeMs <= 0`, skip the percentage math and just emit
  `onProgress?.(0)` once at start and `100` on completion. Document this as the contract: "Pass
  `videoTimeMs` or progress will be coarse."
- Optionally, in a follow-up, use `react-native-video` / `ffprobe` (via the same `FFmpegKit.execute`
  invocation) to read duration from the input file before the main run. Out of scope for v0.1.

### 3. Global vs per-session callbacks (subtle behavior change)

**Problem.** The Flutter code calls `FFmpegKitConfig.enableStatisticsCallback(cb)` once per
`optimizeVideo` invocation, which **overwrites the global callback** on every call. If two
optimizations are kicked off concurrently, the second one's callback replaces the first's, and the
first stops getting progress updates (silently). This is a latent bug in the Flutter package that
nobody has hit because the consumers always serialize calls.

**Mitigation.** The RN port uses per-session callbacks (the 2nd/3rd args of `executeAsync`), which
**fixes the concurrency issue by construction**. Document this as a deliberate improvement; flag in
the README that concurrent optimizations are supported by the RN port even though they're undefined
behavior in the Flutter source.

### 4. Filesystem ops are async in RN, sync in Dart

**Problem.** Flutter uses `File(path).lengthSync()`, `File(path).existsSync()`, etc. RN's
filesystem libraries are all async. The Flutter code's structure assumes sync file ops in places
that don't `await`, which would deadlock if we ported them verbatim.

**Mitigation.** Already designed in: every file op in `FfmpegOptimize.optimizeVideo` is `await`-ed
(see Step 3.2 of the implementation plan). The flow becomes async-correct without any caller-visible
behavior change because the public method is already `Promise<void>`.

### 5. `ffmpeg-kit-react-native` package archival status

**Problem.** Arthenica's repos were archived early 2025. The npm package `ffmpeg-kit-react-native`
hasn't been updated since June 2022 (v6.0.2). The npm latest version still works, but no future
fixes. Community forks exist (`@spreen/ffmpeg-kit-react-native`,
`@sheehanmunim/react-native-ffmpeg`).

**Mitigation.**
- Declare `ffmpeg-kit-react-native` as a peer dependency with a `>=6.0.0` range, **not** a direct
  dependency. This lets consumers swap in whichever fork they prefer, as long as the public API
  matches.
- Document the recommended forks in the README's Installation section.
- Keep our `import` statements limited to `{ FFmpegKit, FFmpegKitConfig, ReturnCode, FFmpegSession }`
  — the smallest possible API surface — so switching forks rarely requires code changes in our
  package.

### 6. Drawtext font availability

**Problem.** The Flutter code calls `FFmpegKitConfig.setFontDirectoryList(...)` with system font
paths so `drawtext` can render. On iOS the path is `/System/Library/Fonts`, on Android `/system/
fonts`. If the device doesn't have a font named in the filter, `drawtext` falls back to the FFmpeg
default — which on some Android devices is missing, causing a runtime error.

**Mitigation.**
- Mirror the Flutter font setup in `util.ts` (`registerApplicationFonts`).
- In the README, document the option to bundle a font file (e.g. `Doppio One.ttf`) inside the
  consuming app's assets and point the font directory at it. The Flutter package already has
  precedent: it maps `MyFontName → Doppio One`.

### 7. GPL-3.0 license propagation

**Problem.** Because we mandate `full-gpl-lts` as the FFmpeg variant, **any app linking against our
package becomes subject to GPLv3**. This is identical to the existing Flutter app's situation, but
worth re-stating for the RN consumers (which may include third-party apps in the future).

**Mitigation.**
- Set `"license": "GPL-3.0-or-later"` in `package.json`.
- Include a verbatim `LICENSE` file.
- Add a clear "License" section to README explaining the GPL implication and offering an
  escape hatch ("if your app cannot be GPL, fork this and swap the FFmpeg variant to `https-lts` —
  you'll lose libx264 support but gain LGPL licensing").

### 8. Existing utility — Flutter `core` package's `Logger.debug`

**Problem.** The Flutter source uses `Logger.debug(tag, [args])` from the `core` package, which the
RN port doesn't have. Mirroring it 1:1 would mean a dependency on a new logging utility.

**Mitigation.** Provide a tiny pluggable seam in `util.ts`:

```ts
let debugLog: (msg: string) => void = (msg) => console.debug('[video-optimizer-rn]', msg);
export function setDebugLog(fn: (msg: string) => void) { debugLog = fn; }
```

Consuming apps that have their own logger (Sentry, custom file logger, etc.) call
`setDebugLog(...)` once at app startup.

## Open Questions for the User

1. **Package name** — `@cashify/video-optimizer-rn`, or follow another org/scope convention?
2. **Where the source repo lives** — new repo under `reglobe/`, or a folder inside one of the
   existing RN repos? The plan assumes a standalone npm package; both options are compatible.
3. **GPLv3 licensing acknowledged** — the Flutter app already ships GPL FFmpeg binaries; confirm
   the same is acceptable for the RN app(s).
4. **`videoTimeMs` source** — should the package itself probe the input file's duration via
   `ffprobe` (extra startup latency, but consumer-friendly), or stay as-is and require the consumer
   to pass it (faster, matches Flutter)? My recommendation: stay as-is for v0.1, revisit if it
   causes friction.