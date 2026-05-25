/**
 * RN root component registered under the name "RnLeafApp". Mounted by Android's
 * RnLeafActivity when Flutter hands off control via the cops/rn_leaf MethodChannel.
 *
 * Initial props (set by CopsRnLeafBridge.buildLaunchOptions):
 *  - route: string — registry key identifying which screen to mount
 *  - paramsJson: string — JSON-encoded map of screen params
 *
 * paramsJson is parsed here so individual screens just receive a plain object.
 */

import React, { useMemo } from 'react';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { renderLeafRoute } from './src/navigation/leaf-route-registry';

type RnLeafAppProps = {
  route?: string;
  paramsJson?: string;
};

function RnLeafApp({ route = '', paramsJson = '{}' }: RnLeafAppProps): React.ReactElement {
  const params = useMemo<Record<string, unknown>>(() => {
    try {
      return JSON.parse(paramsJson) as Record<string, unknown>;
    } catch {
      return {};
    }
  }, [paramsJson]);

  return <SafeAreaProvider>{renderLeafRoute(route, params)}</SafeAreaProvider>;
}

export default RnLeafApp;
