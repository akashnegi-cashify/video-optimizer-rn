import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';
import 'package:flutter_trc/src/modules/elss/common_providers/user_session_provider.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/modules/login/screens/trc_and_qc_login_screen.dart';

import 'widget/logout_modal_widget.dart';

class UserUtil {
  static applicationLogout(BuildContext context) {
    showCshBottomSheet(
      context: context,
      child: LogoutModalWidget(
        onLogoutCallback: () async {
          var loginType = await AppPreferences().getLoginType();
          var loginTypeEnum = LoginTypes.fromValue(loginType ?? "");
          switch (loginTypeEnum) {
            case LoginTypes.trcLogin:
            case LoginTypes.qcLogin:
            case LoginTypes.rmsLogin:
              _onLogout(context, loginTypeEnum);
              break;
            case LoginTypes.shipexLogin:
              _onLogoutComplete(context);
              break;
          }
        },
      ),
    );
  }

  static _onLogout(BuildContext context, LoginTypes loginTypeEnum) {
    var provider = UserSessionProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.logoutUserAndClearSession(loginTypeEnum).then((value) {
      if (value) {
        CshLoading().hideLoading(context);
        _onLogoutComplete(context);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  static _onLogoutComplete(BuildContext context) {
    AppPreferences().resetAndClearAll();
    Navigator.of(context).pushNamedAndRemoveUntil(TrcAndQcLoginScreen.route, (route) => false);
  }
}
