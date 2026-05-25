// Mirrors lib/src/image/image_config.dart.

export interface ImageConfig {
  /** Target width in pixels. If undefined or null, no scaling is applied. Default: 800. */
  imageWidth?: number | null;
  /** FFmpeg -q:v value (1 = best, 31 = worst). Default: 5. */
  optimizationFactor?: number;
  inputUrl: string;
  outputUrl: string;
  onSuccess?: () => void;
  onError?: (msg: string) => void;
}

export interface ResolvedImageConfig {
  imageWidth: number | null;
  optimizationFactor: number;
  inputUrl: string;
  outputUrl: string;
  onSuccess?: () => void;
  onError?: (msg: string) => void;
}

export function withImageConfigDefaults(partial: ImageConfig): ResolvedImageConfig {
  return {
    imageWidth: partial.imageWidth === undefined ? 800 : partial.imageWidth,
    optimizationFactor: partial.optimizationFactor ?? 5,
    inputUrl: partial.inputUrl,
    outputUrl: partial.outputUrl,
    onSuccess: partial.onSuccess,
    onError: partial.onError,
  };
}
