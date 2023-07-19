import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/audit_service.dart';

class AuditQuestionSubmitProvider extends CshChangeNotifier {
  static AuditQuestionSubmitProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<AuditQuestionSubmitProvider>(context, listen: listen);
  }

  //Submit Audit question responses
  Future<bool> submitAuditQuestion(String scannedBarcode, Map<String, dynamic> postData) {
    var completer = Completer<bool>();
    try {
      AuditDataServices.submitAutQuestionResponses(scannedBarcode, postData).listen((event) {
        if (event != null) {
          completer.complete(true);
        }
      }, onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Some error occurred";

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
