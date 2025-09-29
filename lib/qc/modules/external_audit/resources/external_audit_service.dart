import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class ExternalAuditService {
  static Stream<BaseResponse?> submitExternalAudit(
      {int? auditType, String? uid_1, List<String>? videoUrlList, String? uid_2, List<String>? imageUrlList, bool? isReceiveReturn}) {
    var req = {
      "rt": auditType,
      "uid_1": uid_1,
      "vid": videoUrlList,
      "uid_2": uid_2,
      "img": imageUrlList
    };

    if (isReceiveReturn != null) {
      req["isr"] = isReceiveReturn;
    }

    return QcService().post("/recording/external", BaseResponse.fromJson, body: jsonEncode(req));
  }
}
