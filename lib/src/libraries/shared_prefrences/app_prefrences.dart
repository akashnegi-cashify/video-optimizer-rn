import 'package:components/auth/handler/auth_handler.dart';
import 'package:core_widgets/core_widgets.dart';

class AppPreferences {
  static const String IS_LOGIN_FROM_QC = "IsLoginFromQC";
  SharedPreferencesUtil util = SharedPreferencesUtil();

  AppPreferences._privateConstructor();

  static final AppPreferences _instance = AppPreferences._privateConstructor();

  factory AppPreferences() {
    return _instance;
  }

  setIsLoginFromQC(bool value) {
    util.setBool(IS_LOGIN_FROM_QC, value);
  }

  Future<bool?> getIsLoginFromQC() async {
    return await util.getBool(IS_LOGIN_FROM_QC);
  }

  resetAndClearAll() async {
    util.clear();
    await AuthHandler().onSessionExpire();
  }
}
