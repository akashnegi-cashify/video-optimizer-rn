/**
 * Route identifiers shared between Flutter (RnLeafNavigator.openRoute) and RN
 * (LeafRouteRegistry). Keep these strings in sync with any caller-side constants.
 */
export const Routes = {
  RMS_ROOT: 'rms-root',
} as const;

export type RouteName = (typeof Routes)[keyof typeof Routes];
