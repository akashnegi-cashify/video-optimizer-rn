import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

import 'index.dart';

class DispatchLotServices {

  static Stream<BaseResponse?> completeDispatch(String invoiceNumber) {
    Map<String, List<String>> param = {
      "in": [invoiceNumber],
    };
    return QcService().post(
      "/lot-dispatch",
      BaseResponse.fromJson,
      params: param,
    );
  }
}
