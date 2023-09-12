import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';
import 'package:provider/provider.dart';

class CalculatorScannerProvider extends CshChangeNotifier with CalculatorServiceInitMixin {
  static CalculatorScannerProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CalculatorScannerProvider>(context, listen: listen);
  }

  CalculatorScannerProvider() {
    initCalculatorService();
  }

  Future<MyCalculatorResponse> getCalculatorRequest(String? pQuote, String? deviceBarcode) {
    var completer = Completer<MyCalculatorResponse>();
    service.getCalculator(deviceBarcode, pQuote).listen((event) {
      Logger.debug('mydebug-----CalculatorScannerProvider.getCalculatorRequest', [event]);
      if (event != null) {
        completer.complete(event);
      } else {
        completer.completeError("Some internal error occurred");
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
