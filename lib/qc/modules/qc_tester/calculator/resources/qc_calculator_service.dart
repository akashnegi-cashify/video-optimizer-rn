import 'dart:convert';

import 'package:core_widgets/src/resources/services/base_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class QcCalculatorService extends CalculatorService {
  @override
  BaseService getService() {
    return QcService();
  }

  Stream<LobProductListResponse?> getProductList(
      String? deviceBarcode, String? imeiOrSerialNo, bool isImei, bool isManualSearch) {
    Map<String, dynamic> req = {
      "qr": deviceBarcode,
      "im": isManualSearch,
    };
    if (isImei) {
      req["imei"] = imeiOrSerialNo;
    } else {
      req["sno"] = imeiOrSerialNo;
    }

    return QcService().post("/manual-test/search-device", LobProductListResponse.fromJson, body: jsonEncode(req));
  }

  Stream<MyCalculatorResponse?> getLobCalculator(String? deviceBarcode, int? productMasterId, int? productId) {
    Map<String, dynamic> req = {
      "qc": deviceBarcode,
      "pmid": productMasterId.toString(),
      "pid": productId.toString(),
    };
    return QcService().post("/manual-test/calculator/render", MyCalculatorResponse.fromJson, body: jsonEncode(req));
  }
}
