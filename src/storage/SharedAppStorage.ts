import { createMMKV, type MMKV } from 'react-native-mmkv';
import { getFlutterMmkvDir } from '../native/RnLeafModule';

const SHARED_MMKV_ID = 'lego_shared';

let instance: MMKV | null = null;

/**
 * Lazily-constructed MMKV pointing at the same on-disk store Flutter uses for its
 * `AppStorage` (id "lego_shared"). On Android, RN-mmkv defaults to `<filesDir>/mmkv` while
 * Flutter mmkv lives in `<app_flutter>/mmkv` — so we explicitly pass the Flutter directory
 * resolved by the RnLeaf native module.
 *
 * `react-native-mmkv >= 4` uses MMKV core 2.4 (via `io.github.zhongwuzw:mmkv:2.4.0`), the
 * same line Flutter's `com.tencent:mmkv` pulls in. Earlier RN-mmkv 3.x bundled core v2.0.0
 * which couldn't parse the v2.4 file header (`actualSize` was moved out of byte 0 in v2.4),
 * so it silently returned 0 keys despite the file having data.
 */
function getInstance(): MMKV {
  if (instance) {
    return instance;
  }
  instance = createMMKV({
    id: SHARED_MMKV_ID,
    path: getFlutterMmkvDir(),
    mode: 'multi-process',
  });
  return instance;
}

/**
 * Read/write helpers for the shared lego_shared MMKV bucket. Keys here are co-owned with
 * the Flutter `AppStorage` class (flutter_module/lib/src/libraries/get_storage/app_storage.dart)
 * — keep the key strings in sync across both sides.
 */
export const SharedAppStorage = {
  getString(key: string): string | null {
    return getInstance().getString(key) ?? null;
  },
  setString(key: string, value: string): void {
    getInstance().set(key, value);
  },
  remove(key: string): void {
    getInstance().remove(key);
  },
  getAllKeys(): string[] {
    return getInstance().getAllKeys();
  },
};

/** Auth token key — matches enum _AppPreferencesKeys.authToken on the Flutter side. */
export const AUTH_TOKEN_KEY = 'X-User-Auth';

/** Login type key — matches enum _AppPreferencesKeys.loginType on the Flutter side. */
export const LOGIN_TYPE_KEY = 'loginType';

/**
 * Diagnostic helper. Tries multiple candidate paths × candidate mmapIDs to find where the
 * Flutter side actually wrote its data. Returns a list of {path, id, keys, error} so the
 * caller can render the result.
 *
 * Safe to call once and discard — each probe creates a fresh MMKV instance, so failures in
 * one probe don't affect the cached `SharedAppStorage` instance.
 */
export type ProbeResult = {
  path: string;
  id: string;
  keys: string[] | null;
  error: string | null;
};

export function probeSharedStorage(): ProbeResult[] {
  const flutterDir = getFlutterMmkvDir();
  const filesDir = flutterDir.replace(/\/app_flutter\/mmkv$/, '/files/mmkv');

  const candidates: Array<{ path?: string; id: string }> = [
    { path: flutterDir, id: 'lego_shared' },
    { path: filesDir, id: 'lego_shared' },
    { id: 'lego_shared' },
    { path: flutterDir, id: 'mmkv.default' },
    { path: filesDir, id: 'mmkv.default' },
  ];

  return candidates.map(({ path, id }) => {
    try {
      const m = createMMKV({ id, path, mode: 'multi-process' });
      const keys = m.getAllKeys();
      return { path: path ?? '<default>', id, keys, error: null };
    } catch (e) {
      return {
        path: path ?? '<default>',
        id,
        keys: null,
        error: e instanceof Error ? e.message : String(e),
      };
    }
  });
}
