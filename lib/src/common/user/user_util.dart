import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';
import 'package:flutter_trc/src/modules/elss/common_providers/user_session_provider.dart';

import 'widget/logout_modal_widget.dart';
import '../../modules/login/screens/login_screen.dart';

class UserUtil {
  static applicationLogout(BuildContext context) {
    showCshBottomSheet(
      context: context,
      child: LogoutModalWidget(
        onLogoutCallback: () async {
          bool? isLoginFromQC = await AppPreferences().getIsLoginFromQC();
          _onLogout(context, isLoginFromQC ?? false);
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
        Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
