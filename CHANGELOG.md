# Changelog

## 0.1.0 — initial port (2026-05-22)

First release. Port of the Flutter
[`video_optimizer`](https://github.com/reglobe/flutter_packages/tree/main/video_optimizer) package
(v2.0.13) to React Native.

### Added

- `OptimizerController` — singleton with primary + optional fallback video optimizer.
- `FfmpegOptimize` — concrete `AbstVideoOptimizer` backed by `ffmpeg-kit-react-native`.
- `FfmpegImageOptimizer` — concrete `AbstImageOptimizer` for image compression.
- `FfmpegCommand` — pure argument builder with byte-for-byte parity to the Flutter version.
- `VideoConfig`, `VideoCodec`, `VideoPreset`, `VideoTimeConfig` — config DTOs and enums.
- `ImageConfig` — image config DTO.
- `useVideoOptimizer()` — React hook exposing progress, status, and error as state.
- `setDebugLog()` — pluggable debug log seam for routing FFmpeg output to a custom logger.
- 28 unit tests covering enums, defaults, all video command branches, both image command
  branches, and shell quoting.

### Divergences from Flutter

- Log and statistics callbacks are scoped per-FFmpeg-session (RN API style) instead of registered
  globally on `FFmpegKitConfig`. This fixes a latent race in the Flutter source where concurrent
  optimize calls clobber each other's callbacks.
- All filesystem operations are async (RN has no sync filesystem API).
- Dropped the Flutter `core` package's `Logger.debug` — replaced with a pluggable
  `console.debug`-by-default seam via `setDebugLog()`.

### Known limitations

- Without a `videoTimeMs` argument, progress events fire only at 0 % and 100 % (no intermediate
  granularity). The Flutter source has the same constraint.
- `ffmpeg-kit-react-native` is unmaintained as of June 2025 (Arthenica archival). The package
  uses peer dependencies so a community fork can be substituted by the consumer.
