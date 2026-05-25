# @cashify/video-optimizer-rn

React Native port of the Flutter [`video_optimizer`](https://github.com/reglobe/flutter_packages/tree/main/video_optimizer)
package. Wraps [`ffmpeg-kit-react-native`](https://www.npmjs.com/package/ffmpeg-kit-react-native) to
provide a thin, configurable interface for compressing videos and images on-device, with progress
reporting and success/cancel/failure callbacks.

> Status: **v0.1.0** — works end-to-end on Android and iOS (verified on physical devices
> with the sibling example app).

## Why this exists

The Flutter app already has a battle-tested video optimizer. The RN apps need the same compression
behavior (same codec, same drawtext watermark, same progress contract) so artifacts uploaded from
either platform look identical. This package mirrors the Flutter class structure 1-to-1 so the
Flutter source remains the authoritative reference. See
[`src/FfmpegCommand.ts`](src/FfmpegCommand.ts) — every method has a `lib/src/ffmpeg_command.dart`
line reference.

## Installation

```bash
yarn add @cashify/video-optimizer-rn ffmpeg-kit-react-native react-native-fs
# or npm install ...
```

### Pick the FFmpeg variant

This package requires the **`full-gpl-lts`** FFmpeg-kit variant — same as the Flutter source —
because the default command uses `libx264` and the `drawtext` filter, neither of which is in
smaller builds.

**Android** — in your app's `android/build.gradle`:

```gradle
buildscript {
  ext {
    ffmpegKitPackage = "full-gpl-lts"
    // …your other ext values
  }
}
```

**iOS** — in your app's `ios/Podfile`:

```ruby
pod 'ffmpeg-kit-react-native',
  :subspecs => ['full-gpl-lts'],
  :podspec => '../node_modules/ffmpeg-kit-react-native/ffmpeg-kit-react-native.podspec'
```

You will likely also need to **disable autolinking for ffmpeg-kit on iOS** so it doesn't try to
install the default subspec on top of yours. Create or edit `react-native.config.js` in your app:

```js
module.exports = {
  dependencies: {
    'ffmpeg-kit-react-native': {
      platforms: { ios: null },
    },
  },
};
```

Then `cd ios && pod install`.

### Known issue — FFmpeg binaries are no longer hosted

Arthenica (the upstream maintainer of FFmpeg-kit) archived their repositories in **June 2025**.
The npm package `ffmpeg-kit-react-native@6.0.2` still installs, but the underlying native binaries
it tries to download — both the Android Maven artifact (`com.arthenica:ffmpeg-kit-full-gpl:6.0-2.LTS`)
and the iOS framework — now return **404**.

Until a maintained community fork ships replacement binaries, you have two options:

1. **Host the binaries yourself.** Repackage the FFmpeg-kit AAR (the binaries are still inside the
   Flutter plugin `ffmpeg_kit_flutter_android@1.2.0`'s `libs/` folder, ~73 MB) into a local Maven
   repo inside your Android project, and point `dependencyResolutionManagement` at it. A working
   setup is in the sibling `example/` repo (kept separate from this library to avoid the 460 MB
   of FFmpeg binaries bloating the package).
2. **Use a community fork that hosts its own binaries.** Search npm for forks of
   `ffmpeg-kit-react-native`; declare it as the peer dep instead of the original.

You will also need to add the transitive runtime deps that the original Arthenica package didn't
re-export in its `build.gradle`:

```gradle
// android/app/build.gradle
dependencies {
  // ...
  implementation 'com.arthenica:smart-exception-java:0.2.1'
  implementation 'com.arthenica:smart-exception-common:0.2.1'
}
```

These are still on Maven Central.

### Licensing note

`full-gpl-lts` is **GPL-3.0**. Any app shipping this package is subject to GPLv3. If your app cannot
be GPL, swap to the `https-lts` variant — but you lose `libx264` support and the default
`VideoConfig` will produce an FFmpeg command that fails at runtime. You would also need to change
`FfmpegCommand.createArguments` to emit a codec your variant supports.

## Quick start

```ts
import {
  getOptimizerController,
  FfmpegOptimize,
  withVideoConfigDefaults,
} from '@cashify/video-optimizer-rn';

const controller = getOptimizerController({ primary: new FfmpegOptimize() });
await controller.init();

await controller.optimizeVideo({
  inputPath: '/path/to/input.mp4',
  outputPath: '/path/to/output.mp4',
  videoTimeMs: 30_000, // duration of input video; needed for progress %
  config: withVideoConfigDefaults({
    onProgress: (percent) => console.log(`compress: ${percent}%`),
    onProgressEnd: () => console.log('done'),
    onError: (err) => console.error(err),
  }),
});
```

`videoTimeMs` is the input video's duration in milliseconds. If you don't pass it (or pass 0),
the package still runs FFmpeg, but `onProgress` is **not** called — there's no percentage to
compute. To get accurate progress, ask whichever picker/recorder you use for the video duration
and pass it through. `react-native-image-picker`'s asset `duration` field works (seconds, so
multiply by 1000).

## React hook

```tsx
import { useVideoOptimizer, FfmpegOptimize, VideoCodec } from '@cashify/video-optimizer-rn';

function MyScreen() {
  const { optimize, progress, status, error } = useVideoOptimizer({
    primary: new FfmpegOptimize(),
  });

  return (
    <Button
      onPress={() =>
        optimize({
          inputPath: '...',
          outputPath: '...',
          videoTimeMs: 30_000,
          config: { videoCodec: VideoCodec.Libx264 },
        })
      }
      title={status === 'optimizing' ? `${progress}%` : 'Compress'}
    />
  );
}
```

`status` is `'idle' | 'optimizing' | 'success' | 'error' | 'cancelled'`. `progress` is `0..100`.

## API

| Symbol | Purpose |
| --- | --- |
| `OptimizerController` | Singleton with primary + optional fallback optimizer |
| `getOptimizerController(opts)` | Convenience wrapper around `OptimizerController.getInstance` |
| `FfmpegOptimize` | Default video optimizer implementation (delegates to FFmpeg-kit) |
| `FfmpegImageOptimizer` | Default image optimizer implementation |
| `FfmpegCommand` | Pure functions that build FFmpeg argv arrays / image command strings |
| `VideoConfig` | Codec / preset / CRF / callbacks / timestamp burn-in |
| `withVideoConfigDefaults(partial?)` | Applies the same defaults as the Flutter `VideoConfig()` constructor |
| `VideoCodec` | `Libx264` (default) or `Mpeg4` |
| `VideoPreset` | `Ultrafast` … `Veryslow` (9 values; default `Slow`) |
| `VideoTimeConfig` | Optional timestamp watermark settings |
| `videoCodecFromString` / `videoPresetFromString` | Parse a string (e.g. from Firebase Remote Config) into the enum, falling back to defaults |
| `ImageConfig`, `withImageConfigDefaults` | Image optimization config and defaults helper |
| `useVideoOptimizer` | React hook with `progress`, `status`, `error` state |
| `setDebugLog(fn)` | Replace the default `console.debug` logger with your own (Sentry, file logger, etc.) |

## Behavior parity with Flutter

This port aims to be byte-for-byte compatible with the Flutter package's FFmpeg argument output.
The unit tests in [`__tests__/FfmpegCommand.test.ts`](__tests__/FfmpegCommand.test.ts) assert the
generated `string[]` argv against arrays lifted verbatim from the Dart source. If you see different
command-line args being produced for the same `VideoConfig`, that's a bug — please file an issue
with the inputs.

Three **deliberate divergences** from the Flutter behavior, all in our favor:

1. **`executeWithArgumentsAsync` instead of a joined string.** We pass the argv as an array to the
   native bridge, exactly like Flutter does with `executeWithArguments`. This avoids the
   shell-parsing problems that bite anyone using the string-form `executeAsync`, particularly with
   the `drawtext` filter whose value contains spaces (`%Y-%m-%d %H-%M-%S`).
2. **Per-session callbacks instead of global.** The Flutter package registers stats/log callbacks
   globally via `FFmpegKitConfig.enableXCallback`, which means concurrent `optimizeVideo` calls
   clobber each other's progress (silently). The RN port scopes callbacks per session — concurrent
   optimizations work correctly.
3. **Async filesystem ops.** Flutter has sync file APIs (`File(path).lengthSync()`); RN does not.
   All file ops are awaited in the RN port. No visible difference to consumers.

## Local development

If you're hacking on this package:

```bash
yarn install
yarn build      # tsc → dist/
yarn test       # 28 unit tests
```

To test changes inside a real RN app without publishing:

- **Sibling example app** (kept outside this repo to avoid shipping the FFmpeg binaries through
  GitHub) imports the library directly via relative path (`from '../video-optimizer-rn/src'`).
  After making library changes, just reload Metro in the example app — no rebuild needed.
- **In an external app**, the typical approaches are `yarn pack` + install the tarball, or run
  `npm link`. Yarn 4's `portal:` and `link:` protocols both produce symlinks that Metro doesn't
  follow reliably; you'll need `watchFolders` + `disableHierarchicalLookup` in your `metro.config.js`
  to make symlinked installs work (and avoid duplicate React instances).

## License

[GPL-3.0-or-later](./LICENSE). See the [Licensing note](#licensing-note) above for what this means
for your app.
