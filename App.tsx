/**
 * Cashify-OPS — RN host shell (Phase 1).
 *
 * The native side (Android MainActivity / iOS AppDelegate) launches the Flutter
 * UI immediately on cold start, so this component is never visually presented
 * to the user. It exists so AppRegistry has a valid root component and the JS
 * runtime is alive for the CopsFlutter native module.
 *
 * Background color matches the Android launch theme's `consoleThemePrimary`
 * (#0080F0) so any frame-level flash blends with the splash.
 */

import { LegoServiceType } from '@reglobe/lego-core/lego-service/lego-service-type';
import { initializeHttpNative } from '@reglobe/lego-http';
import React, { useEffect } from 'react';
import { StatusBar, View } from 'react-native';
import { LegoApiLogger } from 'react-native-lego-api-logger';

// Bootstrap LegoFetch once at JS init so the RN leaf (login + future flows) hits the
// right CAS / API URLs from the env. Without this, every legoFetch call falls back to
// `localhost` because `LegoServiceGroupInterceptor` has no baseUrl/apiUrl wired up.
// `LegoFetch.init` is idempotent (logs and bails if already initialized) so it's safe
// to call from both the host shell and any future leaf-specific bootstrap.
initializeHttpNative(LegoServiceType.MAIN);

function App(): React.ReactElement {
  useEffect(() => {
    if (__DEV__) {
      LegoApiLogger.start();
    }
  }, []);

  return (
    <View style={{ flex: 1, backgroundColor: '#0080F0' }}>
      <StatusBar hidden />
    </View>
  );
}

export default App;
