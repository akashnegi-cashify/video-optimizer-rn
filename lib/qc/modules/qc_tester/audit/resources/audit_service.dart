import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/resources/new_audit_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/media_submit_request.dart';

import '../models/audit_submission_response.dart';

class AuditDataServices {
  static Stream<NewAuditResponse?> getAuditQuestionnaire(String scannedBarcode, {required BaseService service}) {
    return service.get("/device/test/audit/$scannedBarcode", NewAuditResponse.fromJson);
  }

  static Stream<AuditSubmissionResponse?> submitAutQuestionResponses(
      String scannedBarcode, Map<String, dynamic> postData,
      {List<int>? manualAuditQuestionIds, required BaseService service, List<MediaSubmitRequest>? mediaList}) {
    Map<String, dynamic> req = {
      "ap": postData,
      if (!Validator.isListNullOrEmpty(manualAuditQuestionIds)) "mmaids": manualAuditQuestionIds,
    };
    if (!Validator.isListNullOrEmpty(mediaList)) {
      var encodedList = mediaList!.map((e) => e.toJson()).toList();
      // TODO: need to verify this key
      req["ml"] = encodedList;
    }

    return service.post("/device/test/audit/$scannedBarcode", AuditSubmissionResponse.fromJson, body: jsonEncode(req));
  }
}
