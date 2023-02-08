import 'dart:convert';
import 'package:flutter_trc/src/services/qc_service.dart';
import 'package:flutter_trc/src/services/trc_service.dart';
import '../../home/models/logout_response.dart';
import '../models/elss_device_details_response.dart';
import '../models/elss_success_response.dart';
import '../models/elss_option_response.dart';
import '../models/elss_part_submit_response.dart';
import '../models/part_device_list.dart';
import '../models/upload_fault_images_response.dart';

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

  static Stream<PartDeviceListResponse?> getAddPartItemList(String scannedBarcode) {
    Map<String, List<String>> paramData = {
      "qr": [scannedBarcode],
    };
    return QcServiceElss().get("/device/elss/product/part-list", PartDeviceListResponse.fromJson, params: paramData);
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

  static Stream<LogoutResponse?> logoutAndClearSession() {
    return TrcService().post("/logout", LogoutResponse.fromJson);
  }

  //mark PNA status
  static Stream<ElssSuccessResponse?> markPnaStatus(String scannedCode,
      {List<PartItemDataResponse>? listOfSelectedParts}) {
    Map<String, List<String>> params = {
      "qr": [scannedCode],
    };
    //TODO masking for list of parts.
    return QcServiceElss().post("/device/elss/mark-pna", ElssSuccessResponse.fromJson, params: params);
  }

  //Retest and Reject.
  static Stream<ElssSuccessResponse?> retestOrRejectElss(String scannedBarcode, {bool? isRetest}) {
    Map<String, List<String>> paramsData = {
      "qr": [scannedBarcode],
      if (isRetest != null) "isDefault": ["false"],
    };

    return QcServiceElss().get("/device/elss/re-testing", ElssSuccessResponse.fromJson, params: paramsData);
  }
}
