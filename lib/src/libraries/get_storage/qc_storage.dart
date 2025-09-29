import 'package:flutter_trc/src/libraries/get_storage/base_storage.dart';
import 'package:flutter_trc/src/libraries/get_storage/storage_type.dart';

enum _QcPreferencesKeys {
  qcPin("qcPin"),
  qcBiometrics("qcBiometrics"),
  userAuth("userAuth");

  final String value;

  const _QcPreferencesKeys(this.value);
}

class QcStorage extends BaseStorage {
  QcStorage() : super(StorageType.qcStorage);

  Future<void> setQcMPin(String mPin) {
    return setString(_QcPreferencesKeys.qcPin.value, mPin);
  }

  String? getQcMPin() {
    return getString(_QcPreferencesKeys.qcPin.value);
  }

  Future<void> setIsBioMetricEnabled(bool isBioMetricEnabled) {
    return setBool(_QcPreferencesKeys.qcBiometrics.value, isBioMetricEnabled);
  }

  bool? getIsBioMetricEnabled() {
    return getBool(_QcPreferencesKeys.qcBiometrics.value);
  }

  Future<void> saveUserAuthToken(String token) {
    return setString(_QcPreferencesKeys.userAuth.value, token);
  }

  String? getUserAuth() {
    return getString(_QcPreferencesKeys.userAuth.value);
  }
}
