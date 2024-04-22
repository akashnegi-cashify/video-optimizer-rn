import 'dart:convert';

import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

import '../models/general_response.dart';
import '../models/qc_parts_list_response.dart';

class PartQcServiceElss {
  static Stream<QcPartsListResponse?> getQcPartList({String? pbr = ""}) {
    Map<String, List<String>> paramData = {
      "pbr": [pbr ?? ""]
    };
    return TrcService().get("/qc/parts/list", QcPartsListResponse.fromJson, params: paramData);
  }

  static Stream<GeneralResponse?> submitPartStatus(bool isFaulty, int prid) {
    Map<String, dynamic> bodyData = {
      "isFault": isFaulty,
      "prid": prid,
      "version": 0,
    };
    return TrcService().post("/qc/parts/submit-qc", GeneralResponse.fromJson, body: jsonEncode(bodyData));
  }

  static Stream<BaseActionResponse?> receiveRetrievedParts(String partBarcode) {
    return TrcService().post("/qc/parts/receive-retrieved-part?pbr=$partBarcode", BaseActionResponse.fromJson);
  }

  static Stream<BaseActionResponse?> updateRetrievedPartStatus(bool isFaulty, int partId) {
    Map<String, dynamic> bodyData = {
      "isFault": isFaulty,
      "prid": partId,
    };
    return TrcService()
        .post("/qc/parts/submit-retrieved-part-qc", BaseActionResponse.fromJson, body: jsonEncode(bodyData));
  }
}
