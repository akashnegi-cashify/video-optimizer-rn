import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_submit_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_colors_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_media_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_status_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/media_submit_request.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_quote_request_data.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/qc_calculator_service.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';
import 'package:flutter_trc/trc/trc_calculator_service.dart';

mixin CalculatorServiceInitMixin {
  late CalculatorService service;

  Future<void> initCalculatorService() async {
    var isLoginFromQc = await AppPreferences().getIsLoginFromQC();
    if (Validator.isTrue(isLoginFromQc)) {
      service = QcCalculatorService();
    } else {
      service = TrcCalculatorService();
    }
  }
}

abstract class CalculatorService {
  late BaseService service;

  CalculatorService() {
    service = getService();
  }

  BaseService getService();

  Stream<MyCalculatorResponse?> getCalculator(String? deviceBarcode, String? pQuote) {
    Map<String, dynamic> req = {
      "ib": deviceBarcode,
      "pq_id": pQuote,
    };
    return service.post("/v1/cdp/cal", MyCalculatorResponse.fromJson, body: jsonEncode(req));
  }

  Stream<DeviceColorResponse?> getDeviceColors(int? productId) {
    Map<String, List<String>> params = {
      "pid": [productId.toString()]
    };
    return service.get("/device/color", DeviceColorResponse.fromJson, params: params);
  }

  Stream<DeviceMediaResponse?> getDeviceMedia(String? deviceBarcode) {
    return service.get("/v2/device/media/$deviceBarcode", DeviceMediaResponse.fromJson);
  }

  Stream<DeviceMediaResponse?> submitDeviceMedia(List<MediaSubmitRequest>? mediaList, String? deviceBarcode) {
    var encodedList = mediaList?.map((e) => e.toJson()).toList();
    Map<String, dynamic> request = {"ml": encodedList};
    return service.post("/v3/device/media/$deviceBarcode", DeviceMediaResponse.fromJson, body: jsonEncode(request));
  }

  Stream<CalculatorSubmitResponse?> submitCalculatorResponse(MyQuoteRequestData? quoteRequest, String? deviceBarcode,
      {bool isDeviceTypeLob = false}) {
    String endPoint =
        isDeviceTypeLob ? "/manual-test/calculator/submit/$deviceBarcode" : "/v1/cdp/cal/submit/$deviceBarcode";

    return service.post(
      endPoint,
      CalculatorSubmitResponse.fromJson,
      body: jsonEncode(quoteRequest?.toJson()),
    );
  }

  Stream<DeviceStatusResponse?> getDeviceStatus(String? deviceBarcode) {
    return service.get("/device/status?qrCode=$deviceBarcode", DeviceStatusResponse.fromJson);
  }
}
