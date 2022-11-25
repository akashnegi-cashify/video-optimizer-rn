import 'dart:async';

import 'package:components/auth/handler/auth_handler.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/login_service.dart';

class TRCLoginProvider extends CshChangeNotifier {
  static TRCLoginProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<TRCLoginProvider>(context, listen: listen);
  }

  Future<bool> userLogin(String employeeId, String password) {
    var completer = Completer<bool>();
    try {
      TRCLoginService.userLogin(employeeId, password).listen((event) {
        if (event != null) {
          AuthHandler().setUserAuth(event.token ?? "");
          completer.complete(true);
        } else {
          completer.complete(false);
        }
      }, onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong!!";
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
