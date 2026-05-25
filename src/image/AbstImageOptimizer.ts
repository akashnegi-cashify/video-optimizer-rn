// Mirrors lib/src/image/abst_image_optimizer.dart.

import { ImageConfig } from './ImageConfig';

export interface AbstImageOptimizer {
  init(): Promise<void>;
  optimizeImage(config: ImageConfig): Promise<void>;
}
