import 'dart:convert';

import 'package:flutter_trc/src/services/qc_service.dart';

import 'index.dart';

class DispatchLotServices {
  static Stream<PreDispatchItemResponse?> fetchPreDispatchItemDetail(String groupLotName) {
    Map<String, List<String>> param = {
      "gln": [groupLotName],
    };

    // /lot-device/v1/list
    return QcService().get(
      "/lot/v2/devices",
      PreDispatchItemResponse.fromJson,
      params: param,
    );
  }

  static Stream<ScanPreDispatchResponse?> scanPreLotDispatch(ScanPreDispatchRequest request) {
    return QcService().post(
      "/lot-pre-dispatch/scan",
      ScanPreDispatchResponse.fromJson,
      body: jsonEncode(request),
    );
  }

  static Stream<CompletePreDispatchResponse?> completePreLotDispatch(String groupLotName) {
    return QcService().post("/lot-pre-dispatch/complete", CompletePreDispatchResponse.fromJson,
        body: jsonEncode({"lotGroupName": groupLotName}));
  }
}
