import 'package:flutter/services.dart';

/// Flutter-side handle for opening a React Native "leaf" sub-flow.
///
/// Used to hand control off to RN for migrated modules (RMS first). The native handler
/// starts a dedicated RnLeafActivity that sits on top of the Flutter activity; when the RN
/// flow finishes it returns control to whichever Flutter screen was visible at hand-off time.
///
/// Channel: `cops/rn_leaf` (mirror in Android: CopsRnLeafBridge).
class RnLeafNavigator {
  RnLeafNavigator._();

  static const MethodChannel _channel = MethodChannel('cops/rn_leaf');

  /// Opens the RN leaf with [route] as the screen identifier inside the RN registry.
  /// [params] are JSON-encoded and passed as initial props to the RN root component.
  ///
  /// Returns once the native intent has been dispatched. It does NOT await the user's RN
  /// flow ending — the Flutter activity remains in the back stack and is revealed when the
  /// RN side finishes.
  static Future<void> openRoute(String route, {Map<String, dynamic> params = const {}}) async {
    await _channel.invokeMethod<void>('openRoute', {
      'route': route,
      'params': params,
    });
  }
}
