import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class ExternalAuditService {
  static Stream<BaseResponse?> submitExternalAudit(
      {int? returnType, String? uid_1, List<String>? videoUrlList, String? uid_2, List<String>? imageUrlList, bool? isReceiveReturn}) {
    var req = {
      "rt": returnType,
      "uid_1": uid_1,
      "vid": videoUrlList,
      "uid_2": uid_2,
      "img": imageUrlList
    };

    if (isReceiveReturn != null) {
      req["is_receive_return"] = isReceiveReturn;
    }

    return QcService().post("/recording/external", BaseResponse.fromJson, body: jsonEncode(req));
  }
}
