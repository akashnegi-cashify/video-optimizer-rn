// Mirrors lib/src/ffmpeg_command.dart from the Flutter video_optimizer package.
//
// Critical: the argument arrays produced here must be byte-for-byte identical to the
// Dart version's output. The Dart code at lib/src/ffmpeg_command.dart is the source of
// truth — if you change anything here, mirror it there too (or vice versa).
//
// Note on the drawtext filter: the Dart source has `\\\\:` in its string literals,
// which produces `\:` in the runtime Dart string (because Dart interpolated strings
// require double-backslashes for a single literal backslash). The equivalent in TS
// template literals is `\\:` for the same runtime byte.

import { ResolvedVideoConfig, VideoCodec } from './VideoConfig';
import { ResolvedImageConfig } from './image/ImageConfig';

/**
 * Build the drawtext filter spec used in both libx264 and mpeg4 branches when a
 * timeConfig is present. Returns the value that follows `-vf ` in the FFmpeg
 * argument list.
 */
function buildDrawtextFilter(opts: {
  startTimeSec: number;
  fontSize: number;
  fontColor: string;
  borderColor: string;
}): string {
  const { startTimeSec, fontSize, fontColor, borderColor } = opts;
  // The colons inside `%{pts\\:localtime\\:N\\:format}` need DOUBLE backslash-escapes:
  // FFmpeg unescapes once at filter-graph parse time, then drawtext's text= evaluator
  // unescapes again. With only one backslash, FFmpeg treats the inner colons as filter
  // argument separators and the format string fragments leak out as extra args (e.g.
  // "%Y-%m-%d %H-%M-%S}" becomes the fontcolor value).
  //
  // Mirrors lib/src/ffmpeg_command.dart:22 — Dart source uses '\\\\:' which yields
  // the same `\\:` runtime bytes as this String.raw template (using String.raw avoids
  // escape ambiguity by treating each backslash literally).
  return (
    String.raw`drawtext=text=%{pts\\:localtime\\:${startTimeSec}\\:%Y-%m-%d %H-%M-%S}` +
    `:x=20:y=20:fontsize=${fontSize}:fontcolor=${fontColor}:borderw=1:bordercolor=${borderColor}`
  );
}

/**
 * Quote a single shell-style argument. Conservative: only quotes when necessary.
 * Used because ffmpeg-kit-react-native's executeAsync takes a single string and
 * does its own argv split — paths with spaces or special chars need quoting.
 *
 * Returns the arg unchanged if it has no whitespace or shell metacharacters.
 * Otherwise wraps it in single quotes, escaping any inner single quotes.
 */
export function shellQuote(arg: string): string {
  if (arg === '') return "''";
  if (/^[a-zA-Z0-9._:=+\-/@,%]+$/.test(arg)) {
    return arg;
  }
  // Escape any existing single quotes, then wrap.
  return `'${arg.replace(/'/g, `'\\''`)}'`;
}

/**
 * Join an FFmpeg argument array into a single command string suitable for
 * FFmpegKit.executeAsync. Quotes any arg that contains characters the native-
 * side argv parser might mis-tokenize.
 */
export function joinArguments(args: string[]): string {
  return args.map(shellQuote).join(' ');
}

export class FfmpegCommand {
  /**
   * Mirror of FfmpegCommand.createArguments in the Flutter source.
   * Returns an FFmpeg argv array (without the leading "ffmpeg" program name).
   *
   * @param config  Resolved video config (defaults already applied).
   * @param inputPath  Source video path.
   * @param outputPath  Destination video path.
   * @param _videoTimeMs  Unused here; kept for API parity with the Dart signature.
   */
  static createArguments(
    config: ResolvedVideoConfig,
    inputPath: string,
    outputPath: string,
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    _videoTimeMs?: number,
  ): string[] {
    const timeConfig = config.timeConfig;

    if (config.videoCodec === VideoCodec.Libx264) {
      const codec = 'libx264';
      const preset = config.videoPreset;
      const crf = String(config.crf);

      if (timeConfig !== null && timeConfig !== undefined) {
        const startTime =
          timeConfig.baseTimeInSec ?? Math.floor(Date.now() / 1000);
        const drawtext = buildDrawtextFilter({
          startTimeSec: startTime,
          fontSize: timeConfig.fontSize ?? 24,
          fontColor: timeConfig.fontColor ?? 'white',
          borderColor: timeConfig.borderColor ?? 'black',
        });
        const args: string[] = [
          '-i',
          inputPath,
          '-vf',
          drawtext,
          '-c:v',
          codec,
          '-preset',
          preset,
          '-crf',
          crf,
          '-c:a',
          'copy',
        ];
        if (config.isRemoveAudio) args.push('-an');
        args.push('-movflags', '+faststart', outputPath);
        return args;
      } else {
        const args: string[] = [
          '-i',
          inputPath,
          '-c:v',
          codec,
          '-preset',
          preset,
          '-crf',
          crf,
          '-c:a',
          'copy',
        ];
        if (config.isRemoveAudio) args.push('-an');
        args.push('-movflags', '+faststart', outputPath);
        return args;
      }
    } else {
      // VideoCodec.Mpeg4
      if (timeConfig !== null && timeConfig !== undefined) {
        const startTime =
          timeConfig.baseTimeInSec ?? Math.floor(Date.now() / 1000);
        const drawtext = buildDrawtextFilter({
          startTimeSec: startTime,
          fontSize: timeConfig.fontSize ?? 24,
          fontColor: timeConfig.fontColor ?? 'white',
          borderColor: timeConfig.borderColor ?? 'black',
        });
        return ['-i', inputPath, '-vf', drawtext, '-c:v', 'mpeg4', outputPath];
      } else {
        return ['-i', inputPath, '-c:v', 'mpeg4', outputPath];
      }
    }
  }

  /**
   * Mirror of FfmpegCommand.getImageCommand in the Flutter source.
   * Returns a space-separated command string (not an array) because the Dart
   * image path uses FFmpegKit.execute(command) which takes a string.
   *
   * Note: in this RN port, FFmpegImageOptimizer also expects a string command.
   */
  static getImageCommand(config: ResolvedImageConfig): string {
    const filePath = config.inputUrl;
    const imageWidth = config.imageWidth;
    const optimizationFactor = config.optimizationFactor;
    const outputPath = config.outputUrl;

    if (imageWidth === null || imageWidth === undefined) {
      return `-i ${filePath} -map_metadata -1 -q:v ${optimizationFactor} ${outputPath}`;
    } else {
      return `-i ${filePath} -map_metadata -1 -q:v ${optimizationFactor} -vf scale=${imageWidth}:-1 ${outputPath}`;
    }
  }
}
