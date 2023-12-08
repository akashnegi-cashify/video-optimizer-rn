import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/gaurd/resources/guard_service.dart';
import 'package:provider/provider.dart';

class QcGuardHomeProvider extends CshChangeNotifier {
  static QcGuardHomeProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<QcGuardHomeProvider>(context, listen: listen);
  }

  Future<String> entryScanData(String scannedBarcode) {
    var completer = Completer<String>();
    GuardService.entryScanData(scannedBarcode).listen((event) {
      completer.complete(_getStatusValue(event?.status ?? -1));
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  String _getStatusValue(int status) {
    if (status == -1) {
      return "Error";
    }
    if (status == 1) {
      return "Entry in WH";
    }
    if (status == 0) {
      return "Out from WH";
    } else {
      return "Unknown Status";
    }
  }
}
