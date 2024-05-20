import 'dart:convert';

import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class ImeiValidatorService {
  static Stream<BaseActionResponse?> completeValidation(String? awbNumber, bool? isImei1Matched, bool? isImei2Matched) {
    var req = {
      "awb_number": awbNumber,
      "imei_1": isImei1Matched,
      "imei_2": isImei2Matched,
    };

    return QcService().post("/stock-in/fraud", BaseActionResponse.fromJson, body: jsonEncode(req));
  }
}
