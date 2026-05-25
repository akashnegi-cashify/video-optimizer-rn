import {
  VideoCodec,
  VideoPreset,
  videoCodecFromString,
  videoPresetFromString,
  withVideoConfigDefaults,
  DEFAULT_VIDEO_TIME_CONFIG,
} from '../src/VideoConfig';

describe('videoCodecFromString', () => {
  it('parses known codec strings', () => {
    expect(videoCodecFromString('mpeg4')).toBe(VideoCodec.Mpeg4);
    expect(videoCodecFromString('libx264')).toBe(VideoCodec.Libx264);
  });

  it('falls back to Libx264 for unknown or missing values', () => {
    expect(videoCodecFromString(undefined)).toBe(VideoCodec.Libx264);
    expect(videoCodecFromString(null)).toBe(VideoCodec.Libx264);
    expect(videoCodecFromString('garbage')).toBe(VideoCodec.Libx264);
    expect(videoCodecFromString('')).toBe(VideoCodec.Libx264);
  });
});

describe('videoPresetFromString', () => {
  it('parses every known preset', () => {
    expect(videoPresetFromString('ultrafast')).toBe(VideoPreset.Ultrafast);
    expect(videoPresetFromString('superfast')).toBe(VideoPreset.Superfast);
    expect(videoPresetFromString('veryfast')).toBe(VideoPreset.Veryfast);
    expect(videoPresetFromString('faster')).toBe(VideoPreset.Faster);
    expect(videoPresetFromString('fast')).toBe(VideoPreset.Fast);
    expect(videoPresetFromString('medium')).toBe(VideoPreset.Medium);
    expect(videoPresetFromString('slow')).toBe(VideoPreset.Slow);
    expect(videoPresetFromString('slower')).toBe(VideoPreset.Slower);
    expect(videoPresetFromString('veryslow')).toBe(VideoPreset.Veryslow);
  });

  it('falls back to Slow for unknown or missing values', () => {
    expect(videoPresetFromString(undefined)).toBe(VideoPreset.Slow);
    expect(videoPresetFromString(null)).toBe(VideoPreset.Slow);
    expect(videoPresetFromString('garbage')).toBe(VideoPreset.Slow);
    expect(videoPresetFromString('')).toBe(VideoPreset.Slow);
  });
});

describe('withVideoConfigDefaults', () => {
  it('returns Flutter defaults when given undefined', () => {
    const c = withVideoConfigDefaults();
    expect(c.videoCodec).toBe(VideoCodec.Libx264);
    expect(c.videoPreset).toBe(VideoPreset.Slow);
    expect(c.crf).toBe(30);
    expect(c.isRemoveAudio).toBe(false);
    expect(c.timeConfig).toEqual({
      baseTimeInSec: undefined,
      fontSize: DEFAULT_VIDEO_TIME_CONFIG.fontSize,
      fontColor: DEFAULT_VIDEO_TIME_CONFIG.fontColor,
      borderColor: DEFAULT_VIDEO_TIME_CONFIG.borderColor,
    });
  });

  it('returns Flutter defaults when given an empty object', () => {
    const c = withVideoConfigDefaults({});
    expect(c.videoCodec).toBe(VideoCodec.Libx264);
    expect(c.videoPreset).toBe(VideoPreset.Slow);
    expect(c.crf).toBe(30);
    expect(c.isRemoveAudio).toBe(false);
  });

  it('respects explicit null timeConfig (caller wants no watermark)', () => {
    const c = withVideoConfigDefaults({ timeConfig: null });
    expect(c.timeConfig).toBeNull();
  });

  it('respects explicit null crf', () => {
    const c = withVideoConfigDefaults({ crf: null });
    expect(c.crf).toBeNull();
  });

  it('merges partial timeConfig with defaults', () => {
    const c = withVideoConfigDefaults({ timeConfig: { fontSize: 36 } });
    expect(c.timeConfig).toEqual({
      baseTimeInSec: undefined,
      fontSize: 36,
      fontColor: DEFAULT_VIDEO_TIME_CONFIG.fontColor,
      borderColor: DEFAULT_VIDEO_TIME_CONFIG.borderColor,
    });
  });

  it('passes through user callbacks', () => {
    const onProgress = jest.fn();
    const onError = jest.fn();
    const c = withVideoConfigDefaults({ onProgress, onError });
    expect(c.onProgress).toBe(onProgress);
    expect(c.onError).toBe(onError);
  });
});
