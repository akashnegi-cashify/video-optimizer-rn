import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';
import 'package:flutter_trc/src/modules/elss/common_providers/user_session_provider.dart';
import 'package:flutter_trc/src/modules/login/screens/trc_and_qc_login_screen.dart';

import 'widget/logout_modal_widget.dart';

class UserUtil {
  static applicationLogout(BuildContext context) {
    showCshBottomSheet(
      context: context,
      child: LogoutModalWidget(
        onLogoutCallback: () async {
          bool? isLoginFromQC = await AppPreferences().getIsLoginFromQC();
          bool? isLoginFromShipex = await AppPreferences().getIsLoginFromShipex();
          if (Validator.isTrue(isLoginFromQC)) {
            _onLogout(context, true);
          } else if (Validator.isTrue(isLoginFromShipex)) {
            AppPreferences().resetAndClearAll();
            Navigator.of(context).pushNamedAndRemoveUntil(TrcAndQcLoginScreen.route, (route) => false);
          } else if (Validator.isTrue(isLoginFromQC) == false && Validator.isTrue(isLoginFromShipex) == false) {
            _onLogout(context, false);
          }
        },
      ),
    );
  }

  static _onLogout(BuildContext context, bool loginFromQC) {
    var provider = UserSessionProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.logoutUserAndClearSession(loginFromQC).then((value) {
      if (value) {
        CshLoading().hideLoading(context);
        AppPreferences().resetAndClearAll();
        Navigator.of(context).pushNamedAndRemoveUntil(TrcAndQcLoginScreen.route, (route) => false);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
