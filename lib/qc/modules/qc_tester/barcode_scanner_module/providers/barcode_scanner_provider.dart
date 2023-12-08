import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:core/core.dart';

import '../resources/scanner_service.dart';

class BarcodeScannerProvider extends CshChangeNotifier {
  static BarcodeScannerProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<BarcodeScannerProvider>(context, listen: listen);
  }

  Future<bool> scanBarcodeData(String data) async {
    var completer = Completer<bool>();
    try {
      BarcodeScannerService.scanBarcodeMethod(data).listen((event) {
        if (event != null) {
          completer.complete(true);
        }
      }, onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong";
        completer.completeError(errorMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}
