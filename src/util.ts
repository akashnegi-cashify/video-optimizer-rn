// Mirrors lib/src/util.dart from the Flutter video_optimizer package.
//
// Provides:
//  - getTempDirectory() — RN equivalent of Flutter's getTemporaryDirectory()
//  - bytesToMegabytes / today / now / notNull — string helpers
//  - ffprint — 900-char chunked debug log (matches Flutter behavior)
//  - deleteFile — RNFS.unlink with the same "swallow missing-file errors" semantics
//  - registerApplicationFonts — wires drawtext font dirs into FFmpegKit
//  - setDebugLog — consumer-injectable replacement for Logger.debug

import { FFmpegKitConfig } from 'ffmpeg-kit-react-native';
import RNFS from 'react-native-fs';

let debugLog: (msg: string) => void = (msg) => {
  // eslint-disable-next-line no-console
  console.debug('[video-optimizer-rn]', msg);
};

/**
 * Replace the default debug logger. Useful for routing FFmpeg's output to
 * Sentry, a file, or your app's logging stack.
 */
export function setDebugLog(fn: (msg: string) => void): void {
  debugLog = fn;
}

export function logDebug(msg: string): void {
  debugLog(msg);
}

export function getTempDirectory(): string {
  return RNFS.CachesDirectoryPath;
}

export function bytesToMegabytes(bytes?: number | null): string {
  if (bytes === null || bytes === undefined) return '';
  return (bytes / (1024 * 1024)).toFixed(2);
}

export function today(): string {
  const d = new Date();
  return `${d.getFullYear()}-${d.getMonth() + 1}-${d.getDate()}`;
}

export function now(): string {
  const d = new Date();
  return (
    `${d.getFullYear()}-${d.getMonth() + 1}-${d.getDate()} ` +
    `${d.getHours()}:${d.getMinutes()}:${d.getSeconds()}.${d.getMilliseconds()}`
  );
}

export function notNull(s: string | null | undefined, prefix = ''): string {
  return s === null || s === undefined ? '' : prefix + s;
}

/**
 * Mirror of ffprint() in util.dart: log in 900-char chunks, prefixed with a
 * timestamp. FFmpeg's verbose lines can blow past most logging system limits;
 * chunking matches the Flutter implementation.
 */
export function ffprint(text: string): void {
  const nowString = now();
  const pattern = /.{1,900}/g;
  let match: RegExpExecArray | null;
  while ((match = pattern.exec(text)) !== null) {
    debugLog(`${nowString} - ${match[0]}`);
  }
}

/**
 * Mirror of deleteFile() in util.dart. Idempotent — missing-file errors are
 * swallowed (the file already not existing is the desired end state).
 */
export async function deleteFile(filePath: string): Promise<void> {
  try {
    const exists = await RNFS.exists(filePath);
    if (exists) {
      await RNFS.unlink(filePath);
    }
  } catch (e) {
    debugLog(`deleteFile: Exception thrown inside deleteFile block. ${String(e)}`);
  }
}

/**
 * Mirror of registerApplicationFonts() in util.dart. Tells FFmpegKit where
 * to find fonts for the drawtext filter. Without this, on some Android
 * devices drawtext fails at runtime because no default font is available.
 */
export async function registerApplicationFonts(): Promise<void> {
  const tempDir = getTempDirectory();
  const fontNameMapping: Record<string, string> = {
    MyFontName: 'Doppio One',
  };
  try {
    await FFmpegKitConfig.setFontDirectoryList(
      [tempDir, '/system/fonts', '/System/Library/Fonts'],
      fontNameMapping,
    );
    await FFmpegKitConfig.setEnvironmentVariable(
      'FFREPORT',
      `file=${tempDir}/${today()}-ffreport.txt`,
    );
  } catch (e) {
    debugLog(`registerApplicationFonts: ${String(e)}`);
  }
}
