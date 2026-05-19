import 'package:flutter_trc/src/libraries/get_storage/base_storage.dart';
import 'package:flutter_trc/src/libraries/get_storage/storage_type.dart';

enum _AppPreferencesKeys {
  loginType("loginType");

  final String value;

  const _AppPreferencesKeys(this.value);
}

class AppStorage extends BaseStorage {
  AppStorage() : super(StorageType.appStorage);

  Future<void> setLoginType(String loginType) {
    return setString(_AppPreferencesKeys.loginType.value, loginType);
  }

  String? getLoginType() {
    return getString(_AppPreferencesKeys.loginType.value);
  }
}
