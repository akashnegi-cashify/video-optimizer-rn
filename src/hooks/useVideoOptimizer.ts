// Thin React hook wrapper around OptimizerController. No Flutter equivalent —
// this is the React-idiomatic surface that exposes progress as state so it can
// drive re-renders directly.

import { useCallback, useMemo, useRef, useState } from 'react';

import { OptimizeVideoArgs } from '../AbstVideoOptimizer';
import { OptimizerController, OptimizerControllerOptions } from '../OptimizerController';
import { VideoConfig } from '../VideoConfig';

export type OptimizerStatus = 'idle' | 'optimizing' | 'success' | 'error' | 'cancelled';

export interface UseVideoOptimizerResult {
  optimize: (args: OptimizeVideoArgs) => Promise<void>;
  progress: number; // 0..100
  status: OptimizerStatus;
  error: string | null;
  reset: () => void;
}

export function useVideoOptimizer(opts: OptimizerControllerOptions): UseVideoOptimizerResult {
  // Memoize the controller so we don't recreate it across renders. The singleton
  // factory means subsequent calls just return the existing instance anyway,
  // but this avoids object identity churn.
  const controller = useMemo(
    () => OptimizerController.getInstance(opts),
    // eslint-disable-next-line react-hooks/exhaustive-deps
    [],
  );

  const [progress, setProgress] = useState(0);
  const [status, setStatus] = useState<OptimizerStatus>('idle');
  const [error, setError] = useState<string | null>(null);
  const inFlightRef = useRef(false);

  const optimize = useCallback(
    async (args: OptimizeVideoArgs): Promise<void> => {
      if (inFlightRef.current) {
        throw new Error('useVideoOptimizer: an optimization is already in progress');
      }
      inFlightRef.current = true;
      setStatus('optimizing');
      setProgress(0);
      setError(null);

      // Compose user's config callbacks with our state setters so the hook's
      // progress/status state reflects the optimization.
      const userConfig: VideoConfig = args.config ?? {};
      const composedConfig: VideoConfig = {
        ...userConfig,
        onProgressStart: (videoTimeMs) => {
          setProgress(0);
          userConfig.onProgressStart?.(videoTimeMs);
        },
        onProgress: (pct) => {
          setProgress(pct);
          userConfig.onProgress?.(pct);
        },
        onProgressEnd: () => {
          setProgress(100);
          setStatus('success');
          userConfig.onProgressEnd?.();
        },
        onError: (err) => {
          const msg = err instanceof Error ? err.message : String(err);
          setError(msg);
          // 'Compression operation cancelled' is the exact message FfmpegOptimize
          // emits for ReturnCode.isCancel; recognise it for clearer status state.
          setStatus(msg === 'Compression operation cancelled' ? 'cancelled' : 'error');
          userConfig.onError?.(err);
        },
      };

      try {
        await controller.optimizeVideo({ ...args, config: composedConfig });
      } finally {
        inFlightRef.current = false;
      }
    },
    [controller],
  );

  const reset = useCallback(() => {
    setProgress(0);
    setStatus('idle');
    setError(null);
  }, []);

  return { optimize, progress, status, error, reset };
}
