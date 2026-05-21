import 'package:components/auth/handler/auth_handler.dart';
import 'package:flutter_trc/src/libraries/get_storage/base_storage.dart';
import 'package:flutter_trc/src/libraries/get_storage/storage_type.dart';

enum _AppPreferencesKeys {
  loginType("loginType"),
  authToken("X-User-Auth");

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

  Future<void> saveAuthToken(String token) async {
    // AuthHandler must be set BEFORE any await so the in-memory _userAuth is
    // available to the HTTP interceptor on the very next call, even when this
    // method is invoked fire-and-forget (without await).
    AuthHandler().setUserAuth(token);
    await setString(_AppPreferencesKeys.authToken.value, token);
  }

  String? getAuthToken() {
    return getString(_AppPreferencesKeys.authToken.value);
  }

  Future<void> removeAuthToken() async {
    await remove(_AppPreferencesKeys.authToken.value);
    await AuthHandler().onSessionExpire();
  }
}
