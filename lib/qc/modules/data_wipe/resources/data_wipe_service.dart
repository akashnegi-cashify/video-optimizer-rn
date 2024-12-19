import 'dart:convert';

import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_detail_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_filter_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_list_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class DataWipeService {
  static Stream<DataWipeDetailResponse> getDataWipeDetails(String deviceBarcode) {
    return QcService().get("/erasure-request/create/$deviceBarcode", DataWipeDetailResponse.fromJson);
  }

  static Stream<DataWipeListResponse> getDataWipeList(int pageNo, int pageSize,
      {Map<String, List<int>>? filters}) {
    Map<String, dynamic> req = {"os": pageNo, "ps": pageSize};
    if (filters != null) {
      req["fom"] = filters;
    }

    return QcService().post("/erasure-request/list", DataWipeListResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<DataWipeFilterListResponse> getDataWipeListFilters() {
    return QcService().get("/erasure-request/filter/list", DataWipeFilterListResponse.fromJson);
  }
}
