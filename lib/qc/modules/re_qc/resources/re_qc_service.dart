import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_lot_device_list_response.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/device_accessories_list_response.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/device_report_list_response.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/lot_device_list_response.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class ReQcService {
  static Stream<BaseResponse?> skipReQc(int? lotId) {
    Map<String, int?> req = {"lotId": lotId};
    return QcService().post("/re-qc/v1/skip-re-qc", BaseResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<D2cLotDeviceListResponse?> completeReQc(int? lotId) {
    return QcService().post("/re-qc/v1/complete?lotId=$lotId", D2cLotDeviceListResponse.fromJson);
  }

  static Stream<LotDeviceListResponse?> getLotDeviceList(int? lotId) {
    return QcService().get("/lot-device/v1/list?lid=$lotId'", LotDeviceListResponse.fromJson);
  }

  // static Stream<LotDeviceListResponse?> getTestCases(String? lotGroupName) {
  //   return QcService().post("/lot-re-qc/v2/test-cases", LotDeviceListResponse.fromJson);
  // }

  static Stream<DeviceReportListResponse?> getDeviceReportList(int? deviceId) {
    return QcService().get("/re-qc/v1/device/report-list?did=$deviceId", DeviceReportListResponse.fromJson);
  }

  static Stream<DeviceAccessoriesListResponse?> getDeviceAccessories(int? deviceId) {
    return QcService().get("/lot-re-qc/v2/device/accessories?did=$deviceId", DeviceAccessoriesListResponse.fromJson);
  }

  static Stream<BaseActionResponse?> submitReQcData(
      Map<String, dynamic> misMatch, String? deviceBarcode, String? remarks, int status,
      {String? imagePath}) {
    Map<String, dynamic> req = {"remark": remarks, "mismatchImages": misMatch, "status": status};
    if (!Validator.isNullOrEmpty(imagePath)) {
      req["imageUrl"] = imagePath;
    }

    return QcService()
        .post("/re-qc/v1/device-re-qc/$deviceBarcode", BaseActionResponse.fromJsonWithInt, body: jsonEncode(req));
  }
}
