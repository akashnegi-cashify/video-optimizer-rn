import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_filter_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_smart_watch_action_response.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class DataWipeService {
  static Stream<DataWipeListItem> getDataWipeDetails(String deviceBarcode) {
    return QcService().post("/erasure-request/create/$deviceBarcode", DataWipeListItem.fromJson);
  }

  static Stream<void> initiateDataWipe(int id) {
    return QcService().post_("/erasure-request/start-process?id=$id");
  }

  static Stream<DataWipeListResponse> getDataWipeList(int pageNo, int pageSize, {Map<String, List<int>>? filters}) {
    Map<String, dynamic> req = {"os": pageNo, "ps": pageSize};
    if (filters != null) {
      req["fom"] = filters;
    }

    return QcService().post("/erasure-request/list", DataWipeListResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<DataWipeFilterListResponse> getDataWipeListFilters() {
    return QcService().get("/erasure-request/filter/list", DataWipeFilterListResponse.fromJson);
  }

  static Stream<DataWipeSmartWatchActionResponse?> getSmartWatchActionList() {
    return QcService().get("/erasure-request/cashify/provider/status", DataWipeSmartWatchActionResponse.fromJson);
  }

  static Stream<BaseActionResponse> bulkInitiate(int statusCode) {
    Map<String, dynamic> req = {"sc": statusCode};
    return QcService().post("/erasure-request/bulk-process", BaseActionResponse.fromJson, body: jsonEncode(req));
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
    return QcService()
        .post("/erasure-request/update/$deviceBarcode", BaseActionResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<BaseActionResponse> submitSmartWatchAction(int? id, {required String? action}) {
    Map<String, dynamic> req = {"status": action, "id": id};
    return QcService()
        .post("/erasure-request/start-process/cashify", BaseActionResponse.fromJson, body: jsonEncode(req));
  }
}
