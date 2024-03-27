import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/resources/new_audit_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

import '../models/audit_submission_response.dart';

class AuditDataServices {
  static Stream<NewAuditResponse?> getAuditQuestionnaire(String scannedBarcode) {
    return QcService().get("/device/test/audit/$scannedBarcode", NewAuditResponse.fromJson);
  }

  static Stream<AuditSubmissionResponse?> submitAutQuestionResponses(
      String scannedBarcode, Map<String, dynamic> postData,
      {List<int>? manualAuditQuestionIds}) {
    Map<String, dynamic> req = {
      "ap": postData,
      if (!Validator.isListNullOrEmpty(manualAuditQuestionIds)) "mmaids": manualAuditQuestionIds,
    };

    return QcService()
        .post("/device/test/audit/$scannedBarcode", AuditSubmissionResponse.fromJson, body: jsonEncode(req));
  }
}
