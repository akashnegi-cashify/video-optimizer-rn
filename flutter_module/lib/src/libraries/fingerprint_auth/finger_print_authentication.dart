import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

enum AuthenticationType { face, fingerprint, none }

class FingerPrintAuthentication {
  late LocalAuthentication _auth;

  FingerPrintAuthentication() {
    _auth = LocalAuthentication();
  }

  Future<AuthenticationType?> getAvailableAuthenticationType() async {
    AuthenticationType? availableAuthenticationType;
    List<BiometricType> availableBiometrics = await _auth.getAvailableBiometrics();
    if (availableBiometrics.isEmpty) {
      availableAuthenticationType = AuthenticationType.none;
      return availableAuthenticationType;
    }

    if (isIOS()) {
      if (availableBiometrics.contains(BiometricType.face)) {
        // Face ID.
        availableAuthenticationType = AuthenticationType.face;
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        // Touch ID.
        availableAuthenticationType = AuthenticationType.fingerprint;
      }
    } else {
      availableAuthenticationType = AuthenticationType.fingerprint;
    }
    return availableAuthenticationType;
  }

  Future<bool> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await _auth.authenticate(
          localizedReason: 'Scan your fingerprint to authenticate',
          options: const AuthenticationOptions(useErrorDialogs: true, stickyAuth: true, biometricOnly: true));
    } on PlatformException catch (e) {
      print(e);
    }
    return authenticated;
  }

  Future<bool> canAuthenticate() async {
    return await _auth.canCheckBiometrics;
  }

  Future<bool> checkForAuthenticate() async {
    bool canAuthenticate = false;
    try {
      if (!await _auth.canCheckBiometrics) {
        return false;
      } else {
        List<BiometricType> list = await _auth.getAvailableBiometrics();
        if (list.isEmpty) {
          return false;
        }
        if ((!list.contains(BiometricType.iris))) {
          canAuthenticate = await authenticate();
        } else {
          canAuthenticate = true;
        }
      }
    } on PlatformException catch (e) {
      print(e);
    }
    return canAuthenticate;
  }
}
