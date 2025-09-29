import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

import 'index.dart';

class DispatchLotServices {
  static Stream<DispatchLotsResponse?> getData(DispatchLotRequest request) {
    Map<String, dynamic> req = {
      "offset": request.pageNo,
      "pageSize": request.pageSize,
    };

    Map<String, dynamic>? filterMap;
    if (!Validator.isListNullOrEmpty(request.lotType)) {
      filterMap = {"lt": request.lotType};
    }

    if (isNotEmpty(request.searchQuery)) {
      filterMap ??= {};
      filterMap["q"] = request.searchQuery!;
    }

    if (filterMap != null) {
      req["filterObjectMap"] = filterMap;
    }

    return QcService().post(
      "/lot-dispatch/v2/list",
      DispatchLotsResponse.fromJson,
      body: jsonEncode(req),
    );
  }

  static Stream<DispatchCompleteResponse?> completeDispatch(String invoiceNumber) {
    Map<String, List<String>> param = {
      "in": [invoiceNumber],
    };
    return QcService().post(
      "/lot-dispatch/v2",
      DispatchCompleteResponse.fromJson,
      params: param,
    );
  }
}
