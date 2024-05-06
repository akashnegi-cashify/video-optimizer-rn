import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_submit_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_colors_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_media_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_status_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/manual_question_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/media_submit_request.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_quote_request_data.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/qc_calculator_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';
import 'package:flutter_trc/trc/trc_calculator_service.dart';

abstract class CalculatorServiceInitProvider extends CshChangeNotifier {
  late CalculatorService service;

  CalculatorServiceInitProvider() {
    initCalculatorService();
  }

  Future<void> initCalculatorService() async {
    var isLoginFromQc = await isLoginFromQC();
    if (Validator.isTrue(isLoginFromQc)) {
      service = QcCalculatorService();
    } else {
      service = TrcCalculatorService();
    }
    onServiceInitialized();
  }

  void onServiceInitialized() {}

  Future<bool?> isLoginFromQC() {
    return AppPreferences().getIsLoginFromQC();
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

  Stream<BaseActionResponse?> submitManualQuestions(String? qrCode, List<String?>? questionList) {
    var req = {"dt": questionList};

    return service.post(
      "/manaul-question/submit?qrCode=$qrCode",
      BaseActionResponse.fromJson,
      body: jsonEncode(req),
    );
  }

  Stream<ManualQuestionListResponse?> getManualQuestions(String? qrCode) {
    return service.get("/manaul-question/list?qrCode=$qrCode", ManualQuestionListResponse.fromJson);
  }

  Stream<LobProductListResponse?> getProductList(
      String? deviceBarcode, String? imei, String? serialNo, bool isManualSearch, int? categoryId) {
    Map<String, dynamic> req = {
      "qr": deviceBarcode,
      "im": isManualSearch,
      "cat_id": categoryId.toString(),
    };
    if (!Validator.isNullOrEmpty(imei)) {
      req["imei"] = imei;
    } else {
      req["sno"] = serialNo;
    }

    return service.post("/manual-test/search-device", LobProductListResponse.fromJson, body: jsonEncode(req));
  }

  Stream<MyCalculatorResponse?> getLobCalculator(
      String? deviceBarcode, int? productMasterId, int? productId, int? categoryId) {
    Map<String, dynamic> req = {
      "qc": deviceBarcode,
      "pmid": productMasterId.toString(),
      "pid": productId.toString(),
      "cat_id": categoryId.toString(),
    };
    return service.post("/manual-test/calculator/render", MyCalculatorResponse.fromJson, body: jsonEncode(req));
  }

  Stream<DeviceDetailResponse?> getDeviceDetail(String? deviceBarcode) {
    return service.get("/manual-test/scan-device/$deviceBarcode", DeviceDetailResponse.fromJson);
  }

  Stream<BaseActionResponse?> reportMismatch(List<String?> scannedImeiList, String deviceBarcode, String imeiImageUrl,
      {String? timeoutReason, bool? isImei2Available, bool isAutoApproved = false}) {
    var req = {
      "imei": scannedImeiList,
      "qr": deviceBarcode,
      "image_url": imeiImageUrl,
      "rm": timeoutReason,
      "iaa": isAutoApproved,
      if (isImei2Available != null) "imna": isImei2Available,
    };

    return service.post("/device/mismatch/report/save", BaseActionResponse.fromJson, body: jsonEncode(req));
  }
}
