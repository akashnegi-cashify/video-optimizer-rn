import 'package:components/auth/handler/auth_handler.dart';
import 'package:core_widgets/core_widgets.dart';

class AppPreferences {
  static const String IS_LOGIN_FROM_QC = "IsLoginFromQC";
  static const String IS_LOGIN_FROM_SHIPEX = "isLoginFromShipex";
  static const String IS_LOGIN_FROM_RMS = "isLoginFromRms";
  static const String LOGIN_TYPE = "loginType";
  SharedPreferencesUtil util = SharedPreferencesUtil();

  AppPreferences._privateConstructor();

  static final AppPreferences _instance = AppPreferences._privateConstructor();

  factory AppPreferences() {
    return _instance;
  }

  setLoginType(String loginType) {
    util.setString(LOGIN_TYPE, loginType);
  }

  Future<String?> getLoginType() async {
    return await util.getString(LOGIN_TYPE);
  }

  // setIsLoginFromQC(bool value) {
  //   util.setBool(IS_LOGIN_FROM_QC, value);
  // }
  //
  // Future<bool?> getIsLoginFromQC() async {
  //   return await util.getBool(IS_LOGIN_FROM_QC);
  // }
  //
  // setIsLoginFromShipex(bool value) {
  //   util.setBool(IS_LOGIN_FROM_SHIPEX, value);
  // }
  //
  // Future<bool?> getIsLoginFromShipex() async {
  //   return await util.getBool(IS_LOGIN_FROM_SHIPEX);
  // }

  resetAndClearAll() async {
    util.clear();
    await AuthHandler().onSessionExpire();
  }
}
