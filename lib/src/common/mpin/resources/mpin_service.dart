import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class MPinService {
  static Stream<BaseResponse> submitMPin(String? mPin) {
    var req = {"mp": mPin};
    return QcService().post("/v1/mpin/create", BaseResponse.fromJson, body: jsonEncode(req));
  }
}
