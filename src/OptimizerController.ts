// Mirrors lib/src/optimizer_controller.dart from the Flutter video_optimizer package.
// Singleton — first call to getOptimizerController() defines the optimizers; later
// calls ignore their arguments and return the existing instance.

import { AbstVideoOptimizer, OptimizeVideoArgs } from './AbstVideoOptimizer';

export interface OptimizerControllerOptions {
  primary: AbstVideoOptimizer;
  fallback?: AbstVideoOptimizer;
}

export class OptimizerController {
  private static _instance: OptimizerController | null = null;

  readonly videoOptimizer: AbstVideoOptimizer;
  readonly fallbackVideoOptimizer?: AbstVideoOptimizer;

  private constructor(primary: AbstVideoOptimizer, fallback?: AbstVideoOptimizer) {
    this.videoOptimizer = primary;
    this.fallbackVideoOptimizer = fallback;
  }

  static getInstance(opts: OptimizerControllerOptions): OptimizerController {
    if (!OptimizerController._instance) {
      OptimizerController._instance = new OptimizerController(opts.primary, opts.fallback);
    }
    return OptimizerController._instance;
  }

  /**
   * Clear the singleton. Intended for unit tests only — not in the Flutter API.
   */
  static resetForTesting(): void {
    OptimizerController._instance = null;
  }

  async init(): Promise<void> {
    await this.videoOptimizer.init();
    if (this.fallbackVideoOptimizer) {
      await this.fallbackVideoOptimizer.init();
    }
  }

  async optimizeVideo(args: OptimizeVideoArgs): Promise<void> {
    try {
      await this.videoOptimizer.optimizeVideo(args);
    } catch (e) {
      if (this.fallbackVideoOptimizer) {
        await this.fallbackVideoOptimizer.optimizeVideo(args);
      } else {
        throw e;
      }
    }
  }
}

/**
 * Convenience wrapper mirroring the Dart factory call site.
 */
export function getOptimizerController(opts: OptimizerControllerOptions): OptimizerController {
  return OptimizerController.getInstance(opts);
}
