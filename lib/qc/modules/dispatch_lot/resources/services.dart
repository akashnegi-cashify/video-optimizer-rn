import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

import 'index.dart';

class DispatchLotServices {

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
