// Mirrors lib/src/video_config.dart from the Flutter video_optimizer package.
// Defaults match the Dart VideoConfig() constructor exactly.

export enum VideoCodec {
  Mpeg4 = 'mpeg4',
  Libx264 = 'libx264',
}

export function videoCodecFromString(codec?: string | null): VideoCodec {
  switch (codec) {
    case 'mpeg4':
      return VideoCodec.Mpeg4;
    case 'libx264':
      return VideoCodec.Libx264;
    default:
      return VideoCodec.Libx264;
  }
}

export enum VideoPreset {
  Ultrafast = 'ultrafast',
  Superfast = 'superfast',
  Veryfast = 'veryfast',
  Faster = 'faster',
  Fast = 'fast',
  Medium = 'medium',
  Slow = 'slow',
  Slower = 'slower',
  Veryslow = 'veryslow',
}

export function videoPresetFromString(preset?: string | null): VideoPreset {
  switch (preset) {
    case 'ultrafast':
      return VideoPreset.Ultrafast;
    case 'superfast':
      return VideoPreset.Superfast;
    case 'veryfast':
      return VideoPreset.Veryfast;
    case 'faster':
      return VideoPreset.Faster;
    case 'fast':
      return VideoPreset.Fast;
    case 'medium':
      return VideoPreset.Medium;
    case 'slow':
      return VideoPreset.Slow;
    case 'slower':
      return VideoPreset.Slower;
    case 'veryslow':
      return VideoPreset.Veryslow;
    default:
      return VideoPreset.Slow;
  }
}

export interface VideoTimeConfig {
  baseTimeInSec?: number;
  fontSize?: number;
  fontColor?: string;
  borderColor?: string;
}

export const DEFAULT_VIDEO_TIME_CONFIG: Required<Omit<VideoTimeConfig, 'baseTimeInSec'>> &
  Pick<VideoTimeConfig, 'baseTimeInSec'> = {
  fontSize: 24,
  fontColor: 'white',
  borderColor: 'black',
};

export interface VideoConfig {
  videoCodec?: VideoCodec;
  videoPreset?: VideoPreset;
  crf?: number | null;
  onProgressStart?: (videoTimeMs: number) => void;
  onProgress?: (percent: number) => void;
  onProgressEnd?: () => void;
  onError?: (err: unknown) => void;
  timeConfig?: VideoTimeConfig | null;
  isRemoveAudio?: boolean;
}

export interface ResolvedVideoConfig {
  videoCodec: VideoCodec;
  videoPreset: VideoPreset;
  crf: number | null;
  onProgressStart?: (videoTimeMs: number) => void;
  onProgress?: (percent: number) => void;
  onProgressEnd?: () => void;
  onError?: (err: unknown) => void;
  timeConfig: VideoTimeConfig | null;
  isRemoveAudio: boolean;
}

export function withVideoConfigDefaults(partial?: VideoConfig): ResolvedVideoConfig {
  const p = partial ?? {};
  const resolvedTimeConfig: VideoTimeConfig | null =
    p.timeConfig === null
      ? null
      : {
          baseTimeInSec: p.timeConfig?.baseTimeInSec,
          fontSize: p.timeConfig?.fontSize ?? DEFAULT_VIDEO_TIME_CONFIG.fontSize,
          fontColor: p.timeConfig?.fontColor ?? DEFAULT_VIDEO_TIME_CONFIG.fontColor,
          borderColor: p.timeConfig?.borderColor ?? DEFAULT_VIDEO_TIME_CONFIG.borderColor,
        };

  return {
    videoCodec: p.videoCodec ?? VideoCodec.Libx264,
    videoPreset: p.videoPreset ?? VideoPreset.Slow,
    crf: p.crf === undefined ? 30 : p.crf,
    onProgressStart: p.onProgressStart,
    onProgress: p.onProgress,
    onProgressEnd: p.onProgressEnd,
    onError: p.onError,
    timeConfig: resolvedTimeConfig,
    isRemoveAudio: p.isRemoveAudio ?? false,
  };
}
