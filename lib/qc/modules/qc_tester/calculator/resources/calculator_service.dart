import 'dart:convert';

import 'package:calculator/calculator.dart';
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
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/brand_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/category_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/trc/trc_calculator_service.dart';

abstract class CalculatorServiceInitProvider extends CshChangeNotifier {
  late CalculatorService service;

  CalculatorServiceInitProvider() {
    initCalculatorService();
  }

  void initCalculatorService() {
    var isLoginFromQc = isLoginFromQC();
    if (Validator.isTrue(isLoginFromQc)) {
      service = QcCalculatorService();
    } else {
      service = TrcCalculatorService();
    }
    onServiceInitialized();
  }

  void onServiceInitialized() {}

  bool isLoginFromQC() {
    var loginTypeEnum = LoginTypes.fromValue(AppPreferences.app.getLoginType() ?? "");
    return loginTypeEnum == LoginTypes.qcLogin;
  }
}

abstract class CalculatorService {
  late BaseService service;

  CalculatorService() {
    service = getService();
  }

  BaseService getService();

  Stream<MyCalculatorResponse?> getCalculator(String? deviceBarcode, String? pQuote, int? productId) {
    Map<String, dynamic> req = {"qrCode": deviceBarcode, "sessionId": pQuote, "productId": productId};
    return service.post("/v1/cdp/cal", MyCalculatorResponse.fromJson, body: jsonEncode(req));
  }

  Stream<MyCalculatorResponse?> getPixelCalculator(String? deviceBarcode) {
    return service.get("/calculator-test/calculator/render/$deviceBarcode", MyCalculatorResponse.fromJson);
  }

  Stream<CalculatorSubmitResponse?> submitPixelCalculatorResponse(
      QuoteRequestData? quoteRequest, String? deviceBarcode) {
    return service.post(
      "/calculator-test/calculator/submit/$deviceBarcode",
      CalculatorSubmitResponse.fromJson,
      body: jsonEncode(quoteRequest?.toJson()),
    );
  }

  Stream<DeviceColorResponse?> getDeviceColors(int? productId) {
    Map<String, List<String>> params = {
      "pid": [productId.toString()]
    };
    return service.get("/device/color", DeviceColorResponse.fromJson, params: params);
  }

  Stream<DeviceMediaResponse?> getDeviceMedia(String? deviceBarcode,
      {int? categoryId, MyQuoteRequestData? quoteRequest}) {
    Map<String, dynamic> params = {
      "qrCode": deviceBarcode.toString(),
      if (categoryId != null) "categoryId": categoryId.toString(),
      if (categoryId != null) "csr": quoteRequest
    };

    return service.post("/v1/device/media", DeviceMediaResponse.fromJson, body: jsonEncode(params));
  }

  Stream<DeviceMediaResponse?> submitDeviceMedia(List<MediaSubmitRequest>? mediaList, String? deviceBarcode) {
    var encodedList = mediaList?.map((e) => e.toJson()).toList();
    Map<String, dynamic> request = {"ml": encodedList};
    return service.post("/v1/device/media/$deviceBarcode", DeviceMediaResponse.fromJson, body: jsonEncode(request));
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

  Stream<LobProductListResponse?> getProductListAccToImei(String? imei) {
    return service.get("/manual-test/product/imei/list?imei=$imei", LobProductListResponse.fromJson);
  }

  Stream<MyCalculatorResponse?> getLobCalculator(
      String? deviceBarcode, int? productMasterId, int? productId, int? categoryId, VariantListData? variantItem) {
    Map<String, dynamic> req = {
      "qc": deviceBarcode,
      "pmid": productMasterId.toString(),
      "pid": productId.toString(),
      "cat_id": categoryId.toString(),
    };
    if (variantItem != null) {
      req["vid"] = variantItem.id;
      req["vn"] = variantItem.name;
    }

    return service.post("/manual-test/calculator/render", MyCalculatorResponse.fromJson, body: jsonEncode(req));
  }

  Stream<DeviceDetailResponse?> getDeviceDetail(String? deviceBarcode) {
    return service.get("/manual-test/scan-device/$deviceBarcode", DeviceDetailResponse.fromJson);
  }

  Stream<BaseActionResponse?> reportMismatch(List<String?>? scannedList, String deviceBarcode, String imeiImageUrl,
      {String? timeoutReason, bool? isImei2Available, bool isAutoApproved = false, bool isSerialNo = false}) {
    var req = {
      "qr": deviceBarcode,
      "image_url": imeiImageUrl,
      "rm": timeoutReason,
      "iaa": isAutoApproved,
      if (isImei2Available != null) "imna": isImei2Available,
    };

    if (isSerialNo) {
      req["sno"] = scannedList?.first;
    } else {
      req["imei"] = scannedList;
    }

    return service.post("/device/mismatch/report/save", BaseActionResponse.fromJson, body: jsonEncode(req));
  }

  Stream<VariantListResponse?> getVariantList(int productId) {
    var pagination = Uri.encodeFull(jsonEncode({"pageSize": 1000, "page": 0}));
    var filter = Uri.encodeFull(jsonEncode([
      {
        "type": "EQUALITY",
        "field": "pdid",
        "value": {"search": productId.toString()}
      }
    ]));
    var scm = Uri.encodeFull(jsonEncode(true));
    var url = "/manual-test/search/variant?pagination=$pagination&filter=$filter&scm=$scm";
    return service.get(url, VariantListResponse.fromJson);
  }

  Stream<BrandListResponse?> getBrandList(int? categoryId) {
    return service.get("/manual-test/brand/list/$categoryId", BrandListResponse.fromJson);
  }

  Stream<CategoryResponse?> getCategory(String? barcode, String? sessionId) {
    return service.get("/v1/cdp/scan-device/$barcode/$sessionId", CategoryResponse.fromJson);
  }
}
