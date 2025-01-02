import 'dart:convert';

import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_filter_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_list_response.dart';
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

  static Stream<BaseActionResponse> bulkInitiate(int statusCode) {
    Map<String, dynamic> req = {"sc": statusCode};
    return QcService().post("/erasure-request/bulk-process", BaseActionResponse.fromJson, body: jsonEncode(req));
  }
}
