// Mirrors lib/src/abst_video_optimizer.dart.
// Abstract contract that any video optimizer implementation must satisfy.

import { VideoConfig } from './VideoConfig';

export interface OptimizeVideoArgs {
  inputPath: string;
  outputPath: string;
  config: VideoConfig;
  /**
   * Duration of the input video in milliseconds. Used to compute progress %.
   * If 0 or omitted, progress events fire only at start (0) and end (100).
   */
  videoTimeMs?: number;
}

export interface AbstVideoOptimizer {
  init(): Promise<void>;
  optimizeVideo(args: OptimizeVideoArgs): Promise<void>;
}
