import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { RmsRootScreen } from '../components/rms/RmsRoot/RmsRootScreen';
import { Routes, type RouteName } from './Routes';

type LeafRenderer = (params: Record<string, unknown>) => React.ReactElement;

const REGISTRY: Record<RouteName, LeafRenderer> = {
  [Routes.RMS_ROOT]: (params) => <RmsRootScreen params={params} />,
};

/**
 * Resolves a route string (sent by Flutter via RnLeafNavigator.openRoute) to the React
 * element that should render. Falls back to an explicit "unknown route" screen so a typo
 * in the Flutter call site is obvious rather than silently rendering nothing.
 */
export function renderLeafRoute(
  route: string,
  params: Record<string, unknown>,
): React.ReactElement {
  const renderer = REGISTRY[route as RouteName];
  if (renderer) {
    return renderer(params);
  }
  return <UnknownRouteScreen route={route} />;
}

function UnknownRouteScreen({ route }: { route: string }): React.ReactElement {
  return (
    <View style={styles.root}>
      <Text style={styles.title}>Unknown RN leaf route</Text>
      <Text style={styles.detail}>"{route}"</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  root: { flex: 1, alignItems: 'center', justifyContent: 'center', backgroundColor: '#FFFFFF' },
  title: { fontSize: 18, fontWeight: '600', color: '#B00020', marginBottom: 6 },
  detail: { fontSize: 14, color: '#444444' },
});
