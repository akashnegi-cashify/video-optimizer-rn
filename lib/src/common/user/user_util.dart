import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/modules/elss/common_providers/user_session_provider.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/modules/login/screens/trc_and_qc_login_screen.dart';

import 'widget/logout_modal_widget.dart';

class UserUtil {
  static applicationLogout(BuildContext context) {
    showCshBottomSheet(
      context: context,
      child: LogoutModalWidget(
        onLogoutCallback: () {
          var loginType = AppPreferences.app.getLoginType();
          var loginTypeEnum = LoginTypes.fromValue(loginType ?? "");
          _onLogout(context, loginTypeEnum);
        },
      ),
    );
  }

  static _onLogout(BuildContext context, LoginTypes loginTypeEnum) {
    var provider = UserSessionProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.logoutUserAndClearSession(loginTypeEnum).then((value) {
      if (value && context.mounted) {
        CshLoading().hideLoading(context);
        _onLogoutComplete(context);
      }
    }, onError: (error) {
      if (context.mounted) {
        CshSnackBar.error(context: context, message: error);
        CshLoading().hideLoading(context);
      }
    });
  }

  static _onLogoutComplete(BuildContext context) {
    AppPreferences.instance.resetAndClearAll();
    Navigator.of(context).pushNamedAndRemoveUntil(TrcAndQcLoginScreen.route, (route) => false);
  }
}
