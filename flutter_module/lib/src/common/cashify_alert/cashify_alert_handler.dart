import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';

class CashifyAlertHandler {
  static CashifyAlertHandler instance = CashifyAlertHandler._internal();

  late BuildContext context;

  late Future<bool> Function(CashifyAlert alert) registerAlertCallback;

  factory CashifyAlertHandler() {
    return instance;
  }

  CashifyAlertHandler._internal();

  bool isPopupShowing = false;

  register(BuildContext context) {
    this.context = context;
  }

  Future<bool> onAlertReceived(CashifyAlert? alert, BuildContext? context) {
    if (alert == null || context == null) {
      return Future.value(false);
    }

    Logger.log('onAlertReceived', [alert.actionResponse, isPopupShowing]);

    Completer<bool> completer = Completer();

    if (alert.actionResponse == null) {
      completer.complete(false);
      return completer.future;
    }
    if (isPopupShowing) {
      completer.complete(false);
      return completer.future;
    }

    Logger.log('onAlertReceived showing');

    isPopupShowing = true;

    // TODO
    // bool isCancelable = alert.cancelable == 0;
    // showConfirmDialog(
    //   context,
    //   title: alert.title,
    //   desc: alert.message,
    //   posBtnText: alert.positiveButtonText,
    //   onPosBtnPressed: (BuildContext context) {
    //     completer.complete(true);
    //     isPopupShowing = false;
    //     Navigator.of(context).pop();
    //     ActionTypeExtension.executeAction(alert.actionResponse, null, context);
    //   },
    //   negBtnText: alert.negativeButtonText,
    //   onNegBtnPressed: (BuildContext context) {
    //     completer.complete(true);
    //     isPopupShowing = false;
    //     Navigator.of(context).pop();
    //   },
    //   barrierDismissible: isCancelable,
    //   onBackPressDismiss: (BuildContext context) {
    //     completer.complete(true);
    //     isPopupShowing = false;
    //   },
    // );
    return completer.future;
  }

  void setAlertCallback(Future<bool> Function(CashifyAlert alert) registerAlert) {
    registerAlertCallback = registerAlert;
  }
}
