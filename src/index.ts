// Public barrel. Mirrors lib/index.dart from the Flutter video_optimizer
// package, plus the React hook addition.

export type { AbstVideoOptimizer, OptimizeVideoArgs } from './AbstVideoOptimizer';
export { FfmpegOptimize } from './FfmpegOptimize';
export { FfmpegCommand, shellQuote, joinArguments } from './FfmpegCommand';
export {
  VideoCodec,
  VideoPreset,
  DEFAULT_VIDEO_TIME_CONFIG,
  videoCodecFromString,
  videoPresetFromString,
  withVideoConfigDefaults,
} from './VideoConfig';
export type { VideoConfig, VideoTimeConfig, ResolvedVideoConfig } from './VideoConfig';

export {
  OptimizerController,
  getOptimizerController,
} from './OptimizerController';
export type { OptimizerControllerOptions } from './OptimizerController';

export {
  bytesToMegabytes,
  deleteFile,
  ffprint,
  getTempDirectory,
  logDebug,
  now,
  notNull,
  registerApplicationFonts,
  setDebugLog,
  today,
} from './util';

// Image optimizer (re-exported from src/image/index.ts).
export * from './image';

// React hook (additive — no Flutter equivalent).
export { useVideoOptimizer } from './hooks/useVideoOptimizer';
export type { OptimizerStatus, UseVideoOptimizerResult } from './hooks/useVideoOptimizer';
