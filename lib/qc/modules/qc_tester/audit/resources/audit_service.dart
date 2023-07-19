import 'dart:convert';

import 'package:flutter_trc/src/services/qc_service.dart';

import '../models/audit_question_response.dart';
import '../models/audit_submission_response.dart';
import '../models/s3_details_response.dart';

//Fetch Audit questions
class AuditDataServices {
  static Stream<AuditQuestionResponse?> getAuditQuestionnaire(String scannedBarcode) {
    return QcService().get("/device/test/audit/$scannedBarcode", AuditQuestionResponse.fromJson);
  }

  //submit audit questions
  static Stream<AuditSubmissionResponse?> submitAutQuestionResponses(
      String scannedBarcode, Map<String, dynamic> postData) {
    var bodyData = jsonEncode(postData);
    return QcService().post("/device/test/audit/$scannedBarcode", AuditSubmissionResponse.fromJson, body: bodyData);
  }

}
