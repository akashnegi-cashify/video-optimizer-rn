import 'dart:convert';

import 'package:core_widgets/core_widgets.dart' hide ConsoleService;
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/reject_retest_reason_list_response.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/reject_retest_reason_selection_modal.dart';
import 'package:flutter_trc/src/services/console_service.dart';
import 'package:flutter_trc/src/services/qc_service.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

import '../../home/models/logout_response.dart';
import '../../login/models/authenticate_otp_response.dart';
import '../../login/models/send_otp_response.dart';
import '../common_models/brands_all_products.dart';
import '../common_models/brands_listing_models.dart';
import '../common_models/channel_option_response.dart';
import '../common_models/device_details_submit.dart';
import '../common_models/elss_device_details_response.dart';
import '../common_models/elss_option_response.dart';
import '../common_models/elss_part_submit_response.dart';
import '../common_models/elss_success_response.dart';
import '../common_models/part_device_list.dart';
import '../common_models/parts_elss_action.dart';
import '../common_models/products_colour_response.dart';
import '../common_models/qc_s3_details_config.dart';
import '../common_models/submit_parts_logic_model.dart';
import '../common_models/upload_fault_images_response.dart';

class ElssService {
  static Stream<ElssDeviceDetailsResponse?> getElssDeviceDetails(String scannedBarcode) {
    Map<String, List<String>> paramData = {
      "dbr": [scannedBarcode]
    };
    return TrcService().get("/elss/device-details", ElssDeviceDetailsResponse.fromJson, params: paramData);
  }

  static Stream<ElssOptionResponse?> getElssOptions(String scannedBarcode) {
    Map<String, List<String>> paramData = {
      "dbr": [scannedBarcode]
    };
    return TrcService().get("/elss/actions", ElssOptionResponse.fromJson, params: paramData);
  }

  static Stream<PartDeviceListResponse?> getPartItemList(String scannedBarcode) {
    Map<String, List<String>> paramData = {
      "dbr": [scannedBarcode]
    };
    return TrcService().get("/part/list-device-parts", PartDeviceListResponse.fromJson, params: paramData);
  }

  static Stream<UploadFaultImagesResponse?> uploadPartsFaultImages(
      String scannedBarcode, Map<String, List<String>> imageData) {
    Map<String, dynamic> dataMap = {};
    dataMap["dbr"] = scannedBarcode;
    dataMap["imd"] = imageData;
    return TrcService()
        .post("/part/upload-fault-images", UploadFaultImagesResponse.fromJson, body: jsonEncode(dataMap));
  }

  static Stream<ElssPartSubmitResponse?> elssSubmitPartsRequest(Map<String, dynamic> dataMap) {
    return TrcService().post("/elss/submit-repair-part", ElssPartSubmitResponse.fromJson, body: jsonEncode(dataMap));
  }

  static Stream<LogoutResponse?> trcLogout() {
    return TrcService().post("/logout", LogoutResponse.fromJson);
  }

  static Stream<LogoutResponse?> qcLogout() {
    // TODO: need to integrate logout api of CAS
    // return CasService().post("/user/destroy", LogoutResponse.fromJson);
    return CasService().post("/v1/logout", LogoutResponse.fromJson);
  }

  static Stream<LogoutResponse?> consoleLogout() {
    return ConsoleService().put("/v1/logout", LogoutResponse.fromJson);
  }

  static Stream<BrandsListingResponse?> getBrandsData() {
    return TrcService().get("/brand/list-all-brands", BrandsListingResponse.fromJson);
  }

  static Stream<BrandsAllProductResponse?> getBrandsAllProducts(int bid) {
    Map<String, List<String>> paramsData = {
      "bid": [bid.toString()]
    };
    return TrcService().get("/product/list-all-products", BrandsAllProductResponse.fromJson, params: paramsData);
  }

  static Stream<ProductsColorResponse?> getProductsColoursData(int pid) {
    Map<String, List<String>> paramsData = {
      "pid": [pid.toString()],
    };
    return TrcService().get("/product/list-colors", ProductsColorResponse.fromJson, params: paramsData);
  }

  static Stream<DeviceDetailsSubmit?> submitDeviceDetails(int bid, int pid, String barcode, {String? color}) {
    Map<String, dynamic> bodyData = {
      "bid": bid,
      "pid": pid,
      "dbr": barcode,
      "cl": color,
    };
    return TrcService().post("/device/submit-details", DeviceDetailsSubmit.fromJson, body: jsonEncode(bodyData));
  }

  //----------------------------------------->*************************<-------------------------------------------------//
  //New_QC_APIs

  //mark PNA status
  static Stream<ElssSuccessResponse?> markPnaStatus(String scannedCode, Map<String, dynamic> bodyData) {
    Map<String, List<String>> params = {
      "qr": [scannedCode],
    };

    return QcService()
        .post("/device/elss/mark-pna", ElssSuccessResponse.fromJson, params: params, body: jsonEncode(bodyData));
  }

  static Stream<PartDeviceListResponse?> getAddPartItemList(String scannedBarcode) {
    Map<String, List<String>> paramData = {
      "qr": [scannedBarcode],
    };
    return QcService().get("/device/elss/product/part-list", PartDeviceListResponse.fromJson, params: paramData);
  }

  static Stream<ElssDeviceDetailsResponse?> getDeviceDetailsWithParts(String scannedBarcode) {
    return QcService().get("/device/elss/$scannedBarcode", ElssDeviceDetailsResponse.fromJson);
  }

  static Stream<PartsElssActionResponse?> getElssActionForParts() {
    return QcService().get("/device/elss/actions", PartsElssActionResponse.fromJson);
  }

  static Stream<ElssSuccessResponse?> retestingElss(String barcode, List<int?> reasonIdList) {
    Map<String, dynamic> req = {
      "res": reasonIdList,
    };
    return QcService().post("/device/elss/re-testing?qr=$barcode", ElssSuccessResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<ElssSuccessResponse?> rejectElss(String barcode, List<int?> reasonIdList) {
    Map<String, dynamic> req = {
      "res": reasonIdList,
      "isDefault": "false",
    };
    return QcService().post("/device/elss/reject?qr=$barcode", ElssSuccessResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<SubmitPartsLogicResponse?> submitPartsForLogic(Map<String, dynamic> bodyData) {
    return QcService().post("/device/elss/submit-parts", SubmitPartsLogicResponse.fromJson, body: jsonEncode(bodyData));
  }

  static Stream<ChannelOptionResponse?> getChannelOptions(String barcode) {
    Map<String, List<String>> paramData = {
      "qr": [barcode]
    };
    return QcService().get("/device/elss/channel-options", ChannelOptionResponse.fromJson, params: paramData);
  }

  static Stream<QcS3DetailsResponse?> fetchS3Details() {
    return QcService().get("/v2/s3/config", QcS3DetailsResponse.fromJson);
  }

  static Stream<ElssSuccessResponse?> submitAcceptElss(List<Map<String, dynamic>> partsDataList, String barcode,
      {int? optionId}) {
    Map<String, dynamic> dataMap = {
      "dbr": barcode,
      "opid": optionId,
      "rprl": partsDataList,
    };
    return QcService().post("/device/elss/elss-accept", ElssSuccessResponse.fromJson, body: jsonEncode(dataMap));
  }

  static Stream<ElssDeviceDetailsResponse?> getElssStatusDeviceDetails(String barcode) {
    return QcService().get("/device/elss/details/$barcode", ElssDeviceDetailsResponse.fromJson);
  }

  static Stream<RejectRetestReasonListResponse?> getElssRejectReasonList(ReasonType reasonType) {
    String? baseUrl;
    if (reasonType == ReasonType.reject) {
      baseUrl = "/device/elss/return-reason/elss_reject";
    } else {
      baseUrl = "/device/elss/return-reason/retesting";
    }

    return QcService().get(baseUrl, RejectRetestReasonListResponse.fromJson);
  }

  static Stream<SendOTPResponse?> sendOtp(
      String mobileNumber, String serviceName, String serviceVersion, String notificationType, String at) {
    Map<String, List<String>> data = {
      "mn": [mobileNumber],
      "sern": [serviceName],
      "serv": [serviceVersion],
      "nt": [notificationType],
      "at": [at],
    };

    var headers = CasService().getHeaders(false);
    headers["content-type"] = "application/x-www-form-urlencoded";

    return CasService().post("/v1/auth/otp/send", SendOTPResponse.fromJson,
        params: data, authorization: true, userAuth: false, headers: headers);
  }

  static Stream<AuthenticateOTPResponse?> authenticateOTP(String mobileNumber, String serviceName,
      String serviceVersion, String notificationType, String at, String otp, String rid) {
    Map<String, List<String>> data = {
      "mn": [mobileNumber],
      "sern": [serviceName],
      "serv": [serviceVersion],
      "nt": [notificationType],
      "rid": [rid],
      "otp": [otp],
      "at": [at],
    };
    var headers = CasService().getHeaders(false);
    headers["content-type"] = "application/x-www-form-urlencoded";

    return CasService()
        .post("/v1/auth/otp/authenticate", AuthenticateOTPResponse.fromJson, params: data, headers: headers);
  }

  static Stream<BaseActionResponse?> resetElssTransaction(String? barcode) {
    return QcService().get("/reset-transaction?qr=$barcode", BaseActionResponse.fromJson);
  }
}
