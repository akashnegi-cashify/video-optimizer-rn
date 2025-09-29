import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/brand_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';
import 'package:provider/provider.dart';

class CalculatorScannerProvider extends CalculatorServiceInitProvider {
  static CalculatorScannerProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CalculatorScannerProvider>(context, listen: listen);
  }

  Future<MyCalculatorResponse> getCalculatorRequest(String? pQuote, String? deviceBarcode, int? productId) {
    var completer = Completer<MyCalculatorResponse>();
    service.getCalculator(deviceBarcode, pQuote, productId).listen((event) {
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
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  Future<CategoryData> getCategory(String deviceBarcode, String sessionId) {
    var completer = Completer<CategoryData>();
    service.getCategory(deviceBarcode, sessionId).listen((event) {
      completer.complete(event?.categoryData);
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
