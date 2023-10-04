import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

import 'index.dart';

class DispatchLotServices {
  static Stream<DispatchLotsResponse?> getData(DispatchLotRequest request) {
    Map<String, List<String>> param = {
      "os": ['${request.pageNo}'],
      "ps": ['${request.pageSize}'],
    };

    if(isNotEmpty(request.channelQuery)){
      param["chq"] = [request.channelQuery!];
    }

    if(isNotEmpty(request.searchQuery)){
      param["q"] = [request.searchQuery!];
    }

    return QcService().get(
      "/lot-dispatch/v2",
      DispatchLotsResponse.fromJson,
      params: param,
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

  static Stream<DispatchFilterResponse?> dispatchFilters() {
    return QcService().get(
      "/store-out/v2/list-channels",
      DispatchFilterResponse.fromJson,
    );
  }
}
