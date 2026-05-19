import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/home/resources/home_service.dart';
import 'package:provider/provider.dart';

class HomeScreenProviders extends CshChangeNotifier {
  static HomeScreenProviders of(BuildContext context, {bool listen = true}) {
    return Provider.of<HomeScreenProviders>(context, listen: listen);
  }

  Future<bool> userLogout() {
    var completer = Completer<bool>();
    try {
      HomeScreenService.userLogout().listen((event) {
        completer.complete(true);
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
