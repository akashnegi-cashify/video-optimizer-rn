// Jest mock for ffmpeg-kit-react-native.
// Unit tests for pure-logic files (FfmpegCommand, VideoConfig) don't actually
// hit FFmpeg; they only need this module to load without exploding.
// Integration tests for FfmpegOptimize override these with jest.fn() spies.

export const FFmpegKit = {
  executeAsync: jest.fn(),
  executeWithArgumentsAsync: jest.fn(),
  cancel: jest.fn(),
};

export const FFmpegKitConfig = {
  init: jest.fn(),
  enableLogCallback: jest.fn(),
  enableStatisticsCallback: jest.fn(),
  setFontDirectoryList: jest.fn(),
  setEnvironmentVariable: jest.fn(),
  sessionStateToString: jest.fn((s: unknown) => String(s)),
};

export const ReturnCode = {
  isSuccess: jest.fn(),
  isCancel: jest.fn(),
};

export class FFmpegSession {}
export class Statistics {}
export class Log {}
