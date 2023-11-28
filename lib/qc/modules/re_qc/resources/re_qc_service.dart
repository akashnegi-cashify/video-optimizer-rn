import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/device_accessories_list_response.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/device_report_list_response.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/lot_device_list_response.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/re_qc_list_response.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class ReQcService {
  static Stream<ReQcListResponse?> getReQcList(int pageSize, int offset, {String? searchQuery, List<int>? lotType}) {
    Map<String, dynamic> req = {
      "pageSize": pageSize,
      "offset": offset,
    };

    if (!Validator.isNullOrEmpty(searchQuery) || !Validator.isListNullOrEmpty(lotType)) {
      var filterMap = {
        if (!Validator.isNullOrEmpty(searchQuery)) "q": searchQuery,
        if (!Validator.isListNullOrEmpty(lotType)) "lt": lotType,
      };
      req["filterObjectMap"] = filterMap;
    }

    return QcService().post("/lot-re-qc/v2", ReQcListResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<BaseResponse?> skipReQc(String? lotName) {
    return QcService().post("/lot-re-qc/v3/skip-re-qc?lgn=$lotName", BaseResponse.fromJson);
  }

  static Stream<BaseActionResponse?> completeReQc(String? lotGroupName) {
    return QcService().post("/lot-re-qc/v2/complete?gln=$lotGroupName", BaseActionResponse.fromJson);
  }

  static Stream<LotDeviceListResponse?> getLotDeviceList(String? lotGroupName) {
    return QcService().get("/lot/v2/devices?gln=$lotGroupName", LotDeviceListResponse.fromJson);
  }

  // static Stream<LotDeviceListResponse?> getTestCases(String? lotGroupName) {
  //   return QcService().post("/lot-re-qc/v2/test-cases", LotDeviceListResponse.fromJson);
  // }

  static Stream<DeviceReportListResponse?> getDeviceReportList(int? deviceId) {
    return QcService().get("/lot-re-qc/v3/device/report-list?did=$deviceId", DeviceReportListResponse.fromJson);
  }

  static Stream<DeviceAccessoriesListResponse?> getDeviceAccessories(int? deviceId) {
    return QcService().get("/lot-re-qc/v2/device/accessories?did=$deviceId", DeviceAccessoriesListResponse.fromJson);
  }

  static Stream<BaseActionResponse?> submitReQcData(
      Map<String, dynamic> misMatch, String? deviceBarcode, String? remarks) {
    Map<String, dynamic> req = {"remarks": remarks, "mismatch": misMatch};

    return QcService()
        .post("/lot-re-qc/v3/device-re-qc/$deviceBarcode", BaseActionResponse.fromJson, body: jsonEncode(req));
  }
}
