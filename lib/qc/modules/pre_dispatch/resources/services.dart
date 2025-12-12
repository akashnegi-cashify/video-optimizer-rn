import 'dart:convert';

import 'package:flutter_trc/src/services/qc_service.dart';

import 'index.dart';

class DispatchLotServices {

  static Stream<PreDispatchLotsResponse?> getPreDispatchListData(PreDispatchLotRequest request) {
    // v1 list endpoint is now GET-based; keep this for any existing usages
    final params = <String, List<String>>{
      if (request.pageNo != null) "pageNo": [request.pageNo.toString()],
      if (request.pageSize != null) "pageSize": [request.pageSize.toString()],
    };
    return QcService().get(
      "/lot-pre-dispatch/list",
      PreDispatchLotsResponse.fromJson,
      params: params,
    );
  }

  static Stream<PreDispatchItemResponse?> fetchPreDispatchItemDetail(String groupLotName) {
    Map<String, List<String>> param = {
      "gln": [groupLotName],
    };

    return QcService().get(
      "/lot/v2/devices",
      PreDispatchItemResponse.fromJson,
      params: param,
    );
  }

  static Stream<ScanPreDispatchResponse?> scanPreLotDispatch(ScanPreDispatchRequest request) {
    return QcService().post(
      "/lot-pre-dispatch/v2",
      ScanPreDispatchResponse.fromJson,
      body: jsonEncode(request),
    );
  }

  static Stream<CompletePreDispatchResponse?> completePreLotDispatch(String groupLotName) {
    Map<String, List<String>> param = {
      "lgn": [groupLotName],
    };

    return QcService().post(
      "/lot-pre-dispatch/v2/complete",
      CompletePreDispatchResponse.fromJson,
      params: param,
    );
  }


}
