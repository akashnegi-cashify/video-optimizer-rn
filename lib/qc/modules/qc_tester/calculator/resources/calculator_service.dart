import 'dart:convert';

import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_submit_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_colors_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_media_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_status_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/media_submit_request.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_quote_request_data.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class CalculatorService {
  static Stream<MyCalculatorResponse?> getCalculator(String? deviceBarcode, String? pQuote) {
    Map<String, dynamic> req = {
      "ib": deviceBarcode,
      "pq_id": pQuote,
    };
    return QcService().post("/v1/cdp/cal", MyCalculatorResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<DeviceColorResponse?> getDeviceColors(int? productId) {
    Map<String, List<String>> params = {
      "pid": [productId.toString()]
    };
    return QcService().get("/device/color", DeviceColorResponse.fromJson, params: params);
  }

  static Stream<DeviceMediaResponse?> getDeviceMedia(String? deviceBarcode) {
    return QcService().get("/v2/device/media/$deviceBarcode", DeviceMediaResponse.fromJson);
  }

  static Stream<DeviceMediaResponse?> submitDeviceMedia(List<MediaSubmitRequest>? mediaList, String? deviceBarcode) {
    var encodedList = mediaList?.map((e) => e.toJson()).toList();
    Map<String, dynamic> request = {"ml": encodedList};
    return QcService()
        .post("/v3/device/media/$deviceBarcode", DeviceMediaResponse.fromJson, body: jsonEncode(request));
  }

  static Stream<CalculatorSubmitResponse?> submitCalculatorResponse(
      MyQuoteRequestData? quoteRequest, String? deviceBarcode,
      {bool isDeviceTypeLob = false}) {
    String endPoint =
        isDeviceTypeLob ? "/manual-test/calculator/submit/$deviceBarcode" : "/v1/cdp/cal/submit/$deviceBarcode";

    return QcService().post(
      endPoint,
      CalculatorSubmitResponse.fromJson,
      body: jsonEncode(quoteRequest?.toJson()),
    );
  }

  static Stream<DeviceStatusResponse?> getDeviceStatus(String? deviceBarcode) {
    return QcService().get("/device/status?qrCode=$deviceBarcode", DeviceStatusResponse.fromJson);
  }

  static Stream<LobProductListResponse?> getProductList(String? deviceBarcode) {
    return QcService().get("/manual-test/search-device/$deviceBarcode", LobProductListResponse.fromJson);
  }

  static Stream<MyCalculatorResponse?> getLobCalculator(String? deviceBarcode, int? productMasterId, int? productId) {
    Map<String, dynamic> req = {
      "qc": deviceBarcode,
      "pmid": productMasterId.toString(),
      "pid": productId.toString(),
    };
    return QcService().post("/manual-test/calculator/render", MyCalculatorResponse.fromJson, body: jsonEncode(req));
  }
}
