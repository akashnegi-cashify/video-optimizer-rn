import { NativeModules } from 'react-native';

type CopsFlutterNativeModule = {
  launchFlutter: () => Promise<void>;
};

const { CopsFlutter } = NativeModules as { CopsFlutter: CopsFlutterNativeModule };

/**
 * Presents the Flutter UI on top of the current RN screen.
 *
 * In Phase 1 the native side already auto-launches Flutter on cold start,
 * so this is exposed for future re-entry scenarios when RN screens are added.
 */
export const launchFlutter = (): Promise<void> => CopsFlutter.launchFlutter();
