/**
 * Route identifiers shared between Flutter (RnLeafNavigator.openRoute) and RN
 * (LeafRouteRegistry). Keep these strings in sync with any caller-side constants.
 *
 * The RN side mounts a single React Navigation stack per leaf route; in-stack
 * screen names (e.g. `Login`, `RmsRoot`) are defined in `RnNavigator.tsx` and
 * are NOT exposed here — they are reachable only via in-RN navigation.
 */
export const Routes = {
  LOGIN: 'login',
} as const;

export type RouteName = (typeof Routes)[keyof typeof Routes];
