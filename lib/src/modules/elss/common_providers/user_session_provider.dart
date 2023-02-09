import 'dart:async';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common_resources/elss_service.dart';

class UserSessionProvider extends CshChangeNotifier {
  static UserSessionProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<UserSessionProvider>(context, listen: listen);
  }

  Future<bool> logoutUserAndClearSession() {
    var completer = Completer<bool>();
    try {
      ElssService.logoutAndClearSession().listen((event) {
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
