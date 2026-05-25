// Mirrors lib/src/ffmpeg_optimize.dart from the Flutter video_optimizer package.
//
// Concrete AbstVideoOptimizer that delegates to ffmpeg-kit-react-native.
// The flow matches the Dart implementation step-for-step (see plan §Runtime Flow).
//
// Two deliberate divergences from the Dart code, documented in the plan:
//  1. Log/stats callbacks are passed per-session (RN API style) instead of
//     registered globally via FFmpegKitConfig.enableXCallback. This fixes the
//     concurrent-call race the Dart code has.
//  2. Filesystem ops are async (await RNFS.stat / RNFS.unlink) because RN's
//     filesystem API has no sync variants.

import { FFmpegKit, FFmpegKitConfig, ReturnCode } from 'ffmpeg-kit-react-native';
import RNFS from 'react-native-fs';

import { AbstVideoOptimizer, OptimizeVideoArgs } from './AbstVideoOptimizer';
import { FfmpegCommand } from './FfmpegCommand';
import { withVideoConfigDefaults } from './VideoConfig';
import {
  bytesToMegabytes,
  deleteFile,
  ffprint,
  logDebug,
  registerApplicationFonts,
} from './util';

function clamp(n: number, min: number, max: number): number {
  return Math.max(min, Math.min(max, n));
}

export class FfmpegOptimize implements AbstVideoOptimizer {
  private initialised = false;

  async init(): Promise<void> {
    if (this.initialised) return;
    // Best-effort: enable a default log callback so any session that doesn't
    // override it still produces visible output. Each optimizeVideo() call
    // installs its own per-session log callback that takes precedence.
    try {
      // Older fork APIs may not expose enableLogCallback — guard.
      const maybeFn = (FFmpegKitConfig as unknown as {
        enableLogCallback?: (cb: (log: { getMessage: () => string }) => void) => void;
      }).enableLogCallback;
      if (typeof maybeFn === 'function') {
        maybeFn((log) => logDebug(log.getMessage()));
      }
    } catch (e) {
      logDebug(`FfmpegOptimize.init: enableLogCallback failed (non-fatal): ${String(e)}`);
    }
    await registerApplicationFonts();
    this.initialised = true;
  }

  async optimizeVideo(args: OptimizeVideoArgs): Promise<void> {
    const { inputPath, outputPath } = args;
    const videoTimeMs = args.videoTimeMs ?? 0;
    const config = withVideoConfigDefaults(args.config);

    // 1. Build args (pure).
    const argv = FfmpegCommand.createArguments(config, inputPath, outputPath, videoTimeMs);

    // 2. Fire onProgressStart.
    config.onProgressStart?.(videoTimeMs);

    // 3. Ensure output file doesn't already exist.
    await deleteFile(outputPath);

    // 4. Log input file size (debug only — not fatal if it fails).
    try {
      const stat = await RNFS.stat(inputPath);
      const size = typeof stat.size === 'string' ? parseInt(stat.size, 10) : stat.size;
      logDebug(`FfmpegOptimize.optimizeVideo: inputFileSize=${size} (${bytesToMegabytes(size)} MB)`);
    } catch (e) {
      logDebug(`FfmpegOptimize.optimizeVideo: stat(inputPath) failed: ${String(e)}`);
    }

    ffprint(`FFmpeg process started with arguments: ${JSON.stringify(argv)}`);

    const startedAt = Date.now();

    // 5. Wrap callback-based executeWithArgumentsAsync in a Promise.
    // We use the array-form API (not executeAsync/string) because ffmpeg-kit-react-native's
    // string-form parser does not honour shell quoting — a drawtext filter value containing
    // a space gets split mid-arg. Passing argv as an array mirrors how the Flutter package
    // calls executeWithArguments, side-stepping the issue entirely.
    return new Promise<void>((resolve, reject) => {
      FFmpegKit.executeWithArgumentsAsync(
        argv,
        // Completion callback
        async (session) => {
          const elapsedMs = Date.now() - startedAt;
          logDebug(`FfmpegOptimize.optimizeVideo timeDiff=${elapsedMs}ms`);

          const returnCode = await session.getReturnCode();

          if (ReturnCode.isSuccess(returnCode)) {
            ffprint('Compression completed successfully.');
            try {
              const stat = await RNFS.stat(outputPath);
              const size = typeof stat.size === 'string' ? parseInt(stat.size, 10) : stat.size;
              logDebug(
                `FfmpegOptimize.optimizeVideo: outputFileSize=${size} (${bytesToMegabytes(size)} MB)`,
              );
            } catch (e) {
              logDebug(`FfmpegOptimize.optimizeVideo: stat(outputPath) failed: ${String(e)}`);
            }
            config.onProgressEnd?.();
            resolve();
            return;
          }

          if (ReturnCode.isCancel(returnCode)) {
            const msg = 'Compression operation cancelled';
            ffprint(msg);
            config.onError?.(msg);
            reject(new Error(msg));
            return;
          }

          // Failure path.
          let stackSuffix = '';
          try {
            const trace = await session.getFailStackTrace();
            if (trace) stackSuffix = `\n${trace}`;
          } catch {
            // ignore — stack trace is best-effort
          }
          const state = await session.getState();
          const stateString =
            typeof state === 'string' ? state : FFmpegKitConfig.sessionStateToString(state);
          const msg = `Compression failed with state ${stateString} and rc ${returnCode}.${stackSuffix}`;
          ffprint(msg);
          config.onError?.(msg);
          reject(new Error(msg));
        },
        // Log callback (per-session)
        (log) => {
          logDebug(`VideoOptimize.optimizeVideo: ${log.getMessage()}`);
        },
        // Statistics callback (per-session)
        (stats) => {
          if (videoTimeMs <= 0) return; // can't compute % without duration
          const timeMs = stats.getTime();
          const pct = clamp(Math.floor((timeMs * 100) / videoTimeMs), 0, 100);
          config.onProgress?.(pct);
        },
      );
    });
  }
}
