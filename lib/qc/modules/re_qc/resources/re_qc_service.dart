import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/re_qc_list_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class ReQcService {
  static Stream<ReQcListResponse?> getReQcList(int pageSize, int offset, {String? searchQuery}) {
    Map<String, dynamic> req = {
      "pageSize": pageSize,
      "offset": offset,
    };

    if (!Validator.isNullOrEmpty(searchQuery)) {
      var filterMap = {"q": searchQuery};
      req["filterMap"] = filterMap;
    }

    return QcService().post("/lot-re-qc/v2", ReQcListResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<BaseResponse?> skipReQc(String? lotName) {
    return QcService().post("/lot-re-qc/v3/skip-re-qc?lgn=$lotName", BaseResponse.fromJson);
  }
}
