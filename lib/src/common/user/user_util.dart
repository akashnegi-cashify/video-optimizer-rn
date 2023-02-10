import 'package:components/auth/handler/auth_handler.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/common_providers/user_session_provider.dart';

import 'widget/logout_modal_widget.dart';
import '../../modules/login/login_screen.dart';

class UserUtil {
  static applicationLogout(BuildContext context) {
    showCshBottomSheet(
        context: context,
        child: LogoutModalWidget(
          onLogoutCallback: () {
            _onLogout(context);
          },
        ));
  }

  static _onLogout(BuildContext context) {
    var provider = UserSessionProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.logoutUserAndClearSession().then((value) {
      if (value) {
        CshLoading().hideLoading(context);
        AuthHandler().onSessionExpire();
        Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
