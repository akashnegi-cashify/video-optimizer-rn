import 'dart:async';

import 'package:components/user_details/user_details_response.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/user/user_service.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/modules/elss/common_providers/user_session_provider.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/modules/login/screens/trc_and_qc_login_screen.dart';

import 'my_user_details_response.dart';
import 'widget/logout_modal_widget.dart';

class UserUtil {
  static applicationLogout(BuildContext context) {
    showCshBottomSheet(
      context: context,
      child: LogoutModalWidget(
        onLogoutCallback: () {
          Navigator.pushNamedAndRemoveUntil(context, TrcAndQcLoginScreen.route, (route) => false);
          // var loginType = AppPreferences.app.getLoginType();
          // var loginTypeEnum = LoginTypes.fromValue(loginType ?? "");
          // _onLogout(context, loginTypeEnum);
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

  static Future<MyUserDetailsResponse> onUserLoggedIn() async {
    var completer = Completer<MyUserDetailsResponse>();
    try {
      var userDetails = await _getUserDetails();
      var permissions = await _getUserPermissions(userDetails.mobileMd5);
      var response = MyUserDetailsResponse(userDetails, permissions);
      completer.complete(response);
    } catch (error) {
      completer.completeError(error);
    }
    return completer.future;
  }

  static Future<PermissionResponse> _getUserPermissions(String? mobileMd5) {
    var completer = Completer<PermissionResponse>();
    ConsoleUserService.getUserPermissions(mobileMd5 ?? "").listen((permissionRes) {
      PermissionController().updateUserPermissions(permissionRes);
      completer.complete(permissionRes);
    }).onError((error) {
      completer.completeError(error);
    });
    return completer.future;
  }

  static Future<UserDetailsResponse> _getUserDetails() {
    var completer = Completer<UserDetailsResponse>();
    UserService.getUserDetails().listen((event) {
      completer.complete(event);
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
