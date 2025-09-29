import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/resources/check_device_testing_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/resources/new_audit_response.dart';

import 'audit_submission_response.dart';

class AuditDataServices {
  static Stream<NewAuditResponse?> getAuditQuestionnaire(String scannedBarcode, {required BaseService service}) {
    return service.get("/device/test/audit/$scannedBarcode", NewAuditResponse.fromJson);
  }

  static Stream<AuditSubmissionResponse?> submitAutQuestionResponses(
    String scannedBarcode,
    Map<String, dynamic> postData, {
    List<int>? manualAuditQuestionIds,
    required BaseService service,
  }) {
    Map<String, dynamic> req = {
      "ap": postData,
      if (!Validator.isListNullOrEmpty(manualAuditQuestionIds)) "mmaids": manualAuditQuestionIds,
    };

    return service.post("/device/test/audit/$scannedBarcode", AuditSubmissionResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<CheckDeviceTestingResponse?> checkIsTestingPass(String scannedBarcode, Map<String, dynamic> postData,
      {required BaseService service}) {
    Map<String, dynamic> req = {"ap": postData};

    return service.post("/device/test/audit/$scannedBarcode/check", CheckDeviceTestingResponse.fromJson,
        body: jsonEncode(req));
  }
}
