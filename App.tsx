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

import React from 'react';
import { StatusBar, View } from 'react-native';

function App(): React.ReactElement {
  return (
    <View style={{ flex: 1, backgroundColor: '#0080F0' }}>
      <StatusBar hidden />
    </View>
  );
}

export default App;
