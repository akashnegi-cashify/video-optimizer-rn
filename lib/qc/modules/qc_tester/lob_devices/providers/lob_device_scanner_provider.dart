import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/qc_calculator_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:provider/provider.dart';

class LobDeviceScannerProvider extends CshChangeNotifier {
  static LobDeviceScannerProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<LobDeviceScannerProvider>(context, listen: listen);
  }

  List<LobProductListData>? _productList;

  List<LobProductListData>? get productList => _productList;

  Future<bool> getProductsList(String deviceBarcode, String? imeiOrSearialNo, bool isImei, bool isManualSearch) {
    var completer = Completer<bool>();
    QcCalculatorService().getProductList(deviceBarcode, imeiOrSearialNo, isImei, isManualSearch).listen((event) {
      if (!Validator.isListNullOrEmpty(event?.productList)) {
        _productList = event?.productList;
        completer.complete(true);
      } else {
        completer.complete(false);
      }
      notifyListeners();
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
