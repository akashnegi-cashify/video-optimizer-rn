import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:provider/provider.dart';
import 'package:core/core.dart';

class LobDeviceScannerProvider extends CalculatorServiceInitProvider {
  static LobDeviceScannerProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<LobDeviceScannerProvider>(context, listen: listen);
  }

  Future<List<LobProductListData>?> getProductsList(
      String deviceBarcode, String? imei, String? serialNo, bool isManualSearch, int? categoryId) {
    var completer = Completer<List<LobProductListData>?>();
    service.getProductList(deviceBarcode, imei, serialNo, isManualSearch, categoryId).listen((event) {
      if (!Validator.isListNullOrEmpty(event?.productList)) {
        completer.complete(event?.productList);
      } else {
        completer.completeError("Product List is empty");
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  Future<MyCalculatorResponse?> getLobCalculator(
      String deviceBarcode, int? productMasterId, int? productId, int? categoryId) {
    var completer = Completer<MyCalculatorResponse?>();
    service.getLobCalculator(deviceBarcode, productMasterId, productId, categoryId).listen((event) {
      completer.complete(event);
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  Future<DeviceDetailResponseData?> getDeviceDetail(String deviceBarcode) {
    var completer = Completer<DeviceDetailResponseData?>();
    service.getDeviceDetail(deviceBarcode).listen((event) {
      completer.complete(event?.deviceDetails);
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
