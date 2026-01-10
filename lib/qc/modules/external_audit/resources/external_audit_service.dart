import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class ExternalAuditService {
  static Stream<BaseResponse?> submitExternalAudit(
      {int? auditType, String? uid_1, List<String>? videoUrlList, String? uid_2, List<String>? imageUrlList, bool? isReceiveReturn}) {
    var req = {
      "recordingType": auditType,
      "uid1": uid_1,
      "videos": videoUrlList,
      "uid2": uid_2,
      "images": imageUrlList
    };

    if (isReceiveReturn != null) {
      req["isReturn"] = isReceiveReturn;
    }

    return QcService().post("/external/recording", BaseResponse.fromJson, body: jsonEncode(req));
  }
}
