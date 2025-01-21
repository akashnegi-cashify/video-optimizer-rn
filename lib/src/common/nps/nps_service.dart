import 'dart:convert';

import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/common/nps/resources/nps_question_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class NpsService {
  static Stream<NpsQuestionResponse> getNpsQuestions() {
    return QcService().get("/nps/init/question", NpsQuestionResponse.fromJson);
  }

  static Stream<BaseActionResponse> submitNpsQuestions(Map<String, dynamic> body) {
    return QcService().post("/nps/submit/question", BaseActionResponse.fromJson, body: jsonEncode(body));
  }
}
