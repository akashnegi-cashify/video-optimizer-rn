import { NativeModules } from 'react-native';

type RnLeafNativeModule = {
  finishLeaf: () => void;
  getFlutterMmkvDir: () => string;
};

const { RnLeaf } = NativeModules as { RnLeaf: RnLeafNativeModule };

/**
 * Closes the current RnLeafActivity, returning the user to whichever Flutter screen
 * launched it. No-op if RN is currently rendered in the launcher activity (MainActivity)
 * rather than the leaf one.
 */
export const finishLeaf = (): void => RnLeaf.finishLeaf();

/**
 * Directory where Flutter's `MMKV.initialize()` (with no args) writes its files.
 *
 * Pass as the `path` option when constructing an MMKV instance on the RN side so RN and
 * Flutter share the same on-disk store. Without this override, RN-mmkv defaults to
 * `<filesDir>/mmkv` while Flutter mmkv writes to `<app_flutter>/mmkv` — different files.
 */
export const getFlutterMmkvDir = (): string => RnLeaf.getFlutterMmkvDir();
