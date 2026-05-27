import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import React from 'react';

import { LoginScreen } from '../components/common/LoginScreen';
import { RmsRootScreen } from '../components/rms/RmsRoot/RmsRootScreen';
import type { RootStackParamList } from './types';

const Stack = createNativeStackNavigator<RootStackParamList>();

type Props = {
  /** Params dict forwarded from the Flutter side via the leaf bridge. */
  initialParams: Record<string, unknown>;
};

/**
 * Top-level RN navigator mounted by the leaf route registry. Always boots into
 * the `Login` screen; `LoginScreen` itself decides whether to skip straight to
 * a post-login route based on stored auth + the route param `loginType`.
 */
export function RnNavigator({ initialParams }: Props): React.ReactElement {
  return (
    <NavigationContainer>
      <Stack.Navigator screenOptions={{ headerShown: false }}>
        <Stack.Screen
          name="Login"
          component={LoginScreen}
          initialParams={initialParams as RootStackParamList['Login']}
        />
        <Stack.Screen name="RmsRoot" component={RmsRootScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
