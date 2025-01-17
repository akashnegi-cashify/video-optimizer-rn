import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/brand_list_response.dart';
import 'package:provider/provider.dart';

class CalculatorScannerProvider extends CalculatorServiceInitProvider {
  static CalculatorScannerProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CalculatorScannerProvider>(context, listen: listen);
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

  Future<List<BrandListData>> getBrandList(int categoryId) {
    var completer = Completer<List<BrandListData>>();
    service.getBrandList(categoryId).listen((event) {
      completer.complete(event?.brandList);
      notifyListeners();
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  Future<String> getCategory(String deviceBarcode) {
    // TODO: need to configure this api
    var completer = Completer<String>();
    service.getCategory(deviceBarcode).listen((event) {
      completer.complete("Success");
      notifyListeners();
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
