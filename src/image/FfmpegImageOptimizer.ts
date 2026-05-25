// Mirrors lib/src/image/ffmpeg_image_optimier.dart.
// Same shape as FfmpegOptimize but simpler — no statistics callback, no progress %,
// command is a single string (not an argv array).

import { FFmpegKit, ReturnCode } from 'ffmpeg-kit-react-native';
import RNFS from 'react-native-fs';

import { FfmpegCommand } from '../FfmpegCommand';
import { logDebug } from '../util';
import { AbstImageOptimizer } from './AbstImageOptimizer';
import { ImageConfig, withImageConfigDefaults } from './ImageConfig';

export class FfmpegImageOptimizer implements AbstImageOptimizer {
  async init(): Promise<void> {
    // No-op — mirrors the Dart implementation.
  }

  async optimizeImage(config: ImageConfig): Promise<void> {
    const resolved = withImageConfigDefaults(config);
    const command = FfmpegCommand.getImageCommand(resolved);

    // Delete the output file if it exists.
    try {
      if (resolved.outputUrl) {
        const exists = await RNFS.exists(resolved.outputUrl);
        if (exists) await RNFS.unlink(resolved.outputUrl);
      }
    } catch (e) {
      logDebug(`FfmpegImageOptimizer.optimizeImage: pre-delete failed: ${String(e)}`);
    }

    return new Promise<void>((resolve, reject) => {
      FFmpegKit.executeAsync(
        command,
        async (session) => {
          const rc = await session.getReturnCode();
          if (ReturnCode.isSuccess(rc)) {
            logDebug('FfmpegImageOptimizer.optimizeImage: Image compressed successfully.');
            resolved.onSuccess?.();
            resolve();
            return;
          }
          const msg = 'Error compressing image.';
          logDebug(`FfmpegImageOptimizer.optimizeImage: ${msg}`);
          resolved.onError?.(msg);
          reject(new Error(msg));
        },
        (log) => {
          logDebug(`FfmpegImageOptimizer: ${log.getMessage()}`);
        },
      );
    });
  }
}
