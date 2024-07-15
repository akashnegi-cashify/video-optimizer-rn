import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/home/models/logout_response.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:provider/provider.dart';

import '../common_resources/elss_service.dart';

class UserSessionProvider extends CshChangeNotifier {
  static UserSessionProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<UserSessionProvider>(context, listen: listen);
  }

  Stream<LogoutResponse?>? _getLogoutStream(LoginTypes loginTypeEnum) {
    switch (loginTypeEnum) {
      case LoginTypes.trcLogin:
        return ElssService.trcLogout();
      case LoginTypes.qcLogin:
        return ElssService.qcLogout();
      case LoginTypes.rmsLogin:
        return ElssService.rmsLogout();
      case LoginTypes.shipexLogin:
        // in shepex, we are not calling any logout api
        return null;
    }
  }

  Future<bool> logoutUserAndClearSession(LoginTypes loginTypeEnum) {
    var completer = Completer<bool>();
    try {
      _getLogoutStream(loginTypeEnum)?.listen((event) {
        if (event != null) {
          completer.complete(true);
        } else {
          completer.complete(false);
        }
      }, onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        completer.completeError(errorMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}
