import { FfmpegCommand, shellQuote, joinArguments } from '../src/FfmpegCommand';
import { VideoCodec, VideoPreset, withVideoConfigDefaults } from '../src/VideoConfig';
import { withImageConfigDefaults } from '../src/image/ImageConfig';

// Fix the time so any branch that hits `Date.now()` is deterministic.
// We only assert on this when baseTimeInSec is unset.
const FIXED_NOW_MS = 1716000000000; // 2024-05-18T05:20:00Z; arbitrary but fixed
const FIXED_NOW_SEC = Math.floor(FIXED_NOW_MS / 1000);

beforeEach(() => {
  jest.spyOn(Date, 'now').mockReturnValue(FIXED_NOW_MS);
});
afterEach(() => {
  jest.restoreAllMocks();
});

const INPUT = '/tmp/input.mp4';
const OUTPUT = '/tmp/output.mp4';

describe('FfmpegCommand.createArguments — libx264', () => {
  it('produces the expected args WITH timeConfig (default fonts), audio kept', () => {
    const config = withVideoConfigDefaults({
      videoCodec: VideoCodec.Libx264,
      videoPreset: VideoPreset.Slow,
      crf: 30,
      timeConfig: { baseTimeInSec: 1000000000 },
    });
    expect(FfmpegCommand.createArguments(config, INPUT, OUTPUT)).toEqual([
      '-i',
      INPUT,
      '-vf',
      String.raw`drawtext=text=%{pts\\:localtime\\:1000000000\\:%Y-%m-%d %H-%M-%S}:x=20:y=20:fontsize=24:fontcolor=white:borderw=1:bordercolor=black`,
      '-c:v',
      'libx264',
      '-preset',
      'slow',
      '-crf',
      '30',
      '-c:a',
      'copy',
      '-movflags',
      '+faststart',
      OUTPUT,
    ]);
  });

  it('uses Date.now()/1000 when baseTimeInSec is omitted', () => {
    const config = withVideoConfigDefaults({
      videoCodec: VideoCodec.Libx264,
      timeConfig: {}, // fontSize/colors default; baseTimeInSec missing
    });
    const args = FfmpegCommand.createArguments(config, INPUT, OUTPUT);
    expect(args[3]).toContain(
      String.raw`drawtext=text=%{pts\\:localtime\\:` + FIXED_NOW_SEC + String.raw`\\:`,
    );
  });

  it('produces the expected args WITHOUT timeConfig, audio removed', () => {
    const config = withVideoConfigDefaults({
      videoCodec: VideoCodec.Libx264,
      videoPreset: VideoPreset.Slow,
      crf: 30,
      timeConfig: null,
      isRemoveAudio: true,
    });
    expect(FfmpegCommand.createArguments(config, INPUT, OUTPUT)).toEqual([
      '-i',
      INPUT,
      '-c:v',
      'libx264',
      '-preset',
      'slow',
      '-crf',
      '30',
      '-c:a',
      'copy',
      '-an',
      '-movflags',
      '+faststart',
      OUTPUT,
    ]);
  });

  it('produces the expected args WITH timeConfig, audio removed', () => {
    const config = withVideoConfigDefaults({
      videoCodec: VideoCodec.Libx264,
      videoPreset: VideoPreset.Veryfast,
      crf: 23,
      timeConfig: { baseTimeInSec: 42, fontSize: 30, fontColor: 'red', borderColor: 'blue' },
      isRemoveAudio: true,
    });
    expect(FfmpegCommand.createArguments(config, INPUT, OUTPUT)).toEqual([
      '-i',
      INPUT,
      '-vf',
      String.raw`drawtext=text=%{pts\\:localtime\\:42\\:%Y-%m-%d %H-%M-%S}:x=20:y=20:fontsize=30:fontcolor=red:borderw=1:bordercolor=blue`,
      '-c:v',
      'libx264',
      '-preset',
      'veryfast',
      '-crf',
      '23',
      '-c:a',
      'copy',
      '-an',
      '-movflags',
      '+faststart',
      OUTPUT,
    ]);
  });

  it('produces the expected args WITHOUT timeConfig, audio kept', () => {
    const config = withVideoConfigDefaults({
      videoCodec: VideoCodec.Libx264,
      videoPreset: VideoPreset.Slow,
      crf: 30,
      timeConfig: null,
      isRemoveAudio: false,
    });
    expect(FfmpegCommand.createArguments(config, INPUT, OUTPUT)).toEqual([
      '-i',
      INPUT,
      '-c:v',
      'libx264',
      '-preset',
      'slow',
      '-crf',
      '30',
      '-c:a',
      'copy',
      '-movflags',
      '+faststart',
      OUTPUT,
    ]);
  });
});

describe('FfmpegCommand.createArguments — mpeg4', () => {
  it('produces the expected args WITH timeConfig', () => {
    const config = withVideoConfigDefaults({
      videoCodec: VideoCodec.Mpeg4,
      timeConfig: { baseTimeInSec: 1000000000 },
    });
    expect(FfmpegCommand.createArguments(config, INPUT, OUTPUT)).toEqual([
      '-i',
      INPUT,
      '-vf',
      String.raw`drawtext=text=%{pts\\:localtime\\:1000000000\\:%Y-%m-%d %H-%M-%S}:x=20:y=20:fontsize=24:fontcolor=white:borderw=1:bordercolor=black`,
      '-c:v',
      'mpeg4',
      OUTPUT,
    ]);
  });

  it('produces the expected args WITHOUT timeConfig', () => {
    const config = withVideoConfigDefaults({
      videoCodec: VideoCodec.Mpeg4,
      timeConfig: null,
    });
    expect(FfmpegCommand.createArguments(config, INPUT, OUTPUT)).toEqual([
      '-i',
      INPUT,
      '-c:v',
      'mpeg4',
      OUTPUT,
    ]);
  });
});

describe('FfmpegCommand.getImageCommand', () => {
  it('builds command WITHOUT imageWidth', () => {
    const config = withImageConfigDefaults({
      inputUrl: '/tmp/in.jpg',
      outputUrl: '/tmp/out.jpg',
      imageWidth: null,
      optimizationFactor: 5,
    });
    expect(FfmpegCommand.getImageCommand(config)).toBe(
      '-i /tmp/in.jpg -map_metadata -1 -q:v 5 /tmp/out.jpg',
    );
  });

  it('builds command WITH imageWidth', () => {
    const config = withImageConfigDefaults({
      inputUrl: '/tmp/in.jpg',
      outputUrl: '/tmp/out.jpg',
      imageWidth: 800,
      optimizationFactor: 5,
    });
    expect(FfmpegCommand.getImageCommand(config)).toBe(
      '-i /tmp/in.jpg -map_metadata -1 -q:v 5 -vf scale=800:-1 /tmp/out.jpg',
    );
  });

  it('defaults imageWidth to 800 when not specified', () => {
    const config = withImageConfigDefaults({
      inputUrl: '/tmp/in.jpg',
      outputUrl: '/tmp/out.jpg',
    });
    expect(FfmpegCommand.getImageCommand(config)).toBe(
      '-i /tmp/in.jpg -map_metadata -1 -q:v 5 -vf scale=800:-1 /tmp/out.jpg',
    );
  });
});

describe('shellQuote', () => {
  it('returns simple alphanumeric args unchanged', () => {
    expect(shellQuote('-i')).toBe('-i');
    expect(shellQuote('libx264')).toBe('libx264');
    expect(shellQuote('+faststart')).toBe('+faststart');
    expect(shellQuote('30')).toBe('30');
    expect(shellQuote('/tmp/no-spaces.mp4')).toBe('/tmp/no-spaces.mp4');
  });

  it('quotes args with spaces', () => {
    expect(shellQuote('/sdcard/My Videos/clip.mp4')).toBe(`'/sdcard/My Videos/clip.mp4'`);
  });

  it('quotes args with shell metacharacters', () => {
    expect(shellQuote('value;rm -rf')).toBe(`'value;rm -rf'`);
    expect(shellQuote('a"b')).toBe(`'a"b'`);
    expect(shellQuote('a\\b')).toBe(`'a\\b'`);
  });

  it('escapes embedded single quotes', () => {
    expect(shellQuote(`it's`)).toBe(`'it'\\''s'`);
  });

  it('handles empty string', () => {
    expect(shellQuote('')).toBe(`''`);
  });

  it('quotes drawtext filter value (contains spaces and colons)', () => {
    const drawtext = String.raw`drawtext=text=%{pts\\:localtime\\:1000\\:%Y-%m-%d %H-%M-%S}:x=20:y=20:fontsize=24:fontcolor=white:borderw=1:bordercolor=black`;
    const quoted = shellQuote(drawtext);
    expect(quoted.startsWith("'")).toBe(true);
    expect(quoted.endsWith("'")).toBe(true);
  });
});

describe('joinArguments', () => {
  it('joins simple args with spaces, no quoting', () => {
    expect(joinArguments(['-i', 'input.mp4', '-c:v', 'libx264', 'output.mp4'])).toBe(
      '-i input.mp4 -c:v libx264 output.mp4',
    );
  });

  it('quotes args containing spaces', () => {
    expect(joinArguments(['-i', '/path with space/in.mp4', 'out.mp4'])).toBe(
      `-i '/path with space/in.mp4' out.mp4`,
    );
  });
});
