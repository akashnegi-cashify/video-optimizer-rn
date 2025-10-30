import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_filter_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_smart_watch_action_response.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/services/qc_erazer_service.dart';


class DataWipeService {
  static Stream<DataWipeListItem> getDataWipeDetails(String deviceBarcode) {
    return QcErazerService().post("/v1/data-erasure/create/$deviceBarcode", DataWipeListItem.fromJson);
  }

  static Stream<void> initiateDataWipe(int id) {
    return QcErazerService().post_(
      "/v1/data-erasure/start-process",
      body: jsonEncode({"id": id}),
    );
  }

  static Stream<DataWipeListResponse> getDataWipeList(int pageNo, int pageSize, {Map<String, List<int>>? filters}) {
    Map<String, dynamic> req = {"os": pageNo, "ps": pageSize};
    if (filters != null) {
      req["fom"] = filters;
    }

    return QcErazerService().post("/v1/data-erasure/list", DataWipeListResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<DataWipeFilterListResponse> getDataWipeListFilters() {
    return QcErazerService().get("/v1/data-erasure/filter/list", DataWipeFilterListResponse.fromJson);
  }

  static Stream<DataWipeListResponse> getDataWipeConsoleList() {
    return QcErazerService().get("/v1/data-erasure/list", DataWipeListResponse.fromJson);
  }

  static Stream<DataWipeSmartWatchActionResponse?> getSmartWatchActionList() {
    return QcErazerService().get("/v1/data-erasure/cashify/provider/status", DataWipeSmartWatchActionResponse.fromJson);
  }

  static Stream<BaseActionResponse> bulkInitiate(int statusCode) {
    Map<String, dynamic> req = {"sc": statusCode};
    return QcErazerService().post("/v1/data-erasure/bulk-process", BaseActionResponse.fromJson, body: jsonEncode(req));
    // return QcService().post("/erasure-request/bulk-process", BaseActionResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<BaseActionResponse> reportMisMatch(
    String deviceBarcode, {
    String? imei1,
    String? imei2,
    String? serialNo,
  }) {
    Map<String, dynamic> req = {
      if (!Validator.isNullOrEmpty(imei1)) "imei": imei1,
      if (!Validator.isNullOrEmpty(imei2)) "imei2": imei2,
      if (!Validator.isNullOrEmpty(serialNo)) "sno": serialNo,
    };
    return QcErazerService()
        .post("/v1/data-erasure/update/$deviceBarcode", BaseActionResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<BaseActionResponse> submitSmartWatchAction(int? id, {required String? action}) {
    Map<String, dynamic> req = {"status": action, "id": id};
    return QcErazerService()
        .post("/v1/data-erasure/start-process", BaseActionResponse.fromJson, body: jsonEncode(req));
  }
}
