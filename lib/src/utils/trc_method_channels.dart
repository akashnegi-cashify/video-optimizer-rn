import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';
import 'package:flutter_trc/src/modules/login/screens/trc_and_qc_login_screen.dart';

class NativeCall {
  static MethodChannel platformMethodChannel = const MethodChannel('in.cashify.trc/plugin');

  static Future<void> sendUserDataToNativeSide(String objectData) async {
    await platformMethodChannel.invokeMethod('userauthdetails', objectData);
  }

  static Future<void> registerLogout(BuildContext context) async {
    Logger.debug('mydebug------NativeCall.registerLogout', ["This method called for method channel log out---"]);
    platformMethodChannel.invokeMethod('registerLogout').then((value) => {
          onLogout(context),
        });
  }

  static void onLogout(BuildContext context) async {
    await AppPreferences().resetAndClearAll();
    Navigator.of(context).pushNamedAndRemoveUntil(TrcAndQcLoginScreen.route, (route) => false);
  }
}
