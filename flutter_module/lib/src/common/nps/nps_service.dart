import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/common/nps/resources/nps_question_response.dart';

class NpsService {
  static Stream<NpsQuestionResponse> getNpsQuestions({required BaseService service}) {
    return service.get("/nps/list", NpsQuestionResponse.fromJson);
  }

  static Stream<BaseActionResponse> submitNpsQuestions(Map<String, dynamic> body, {required BaseService service}) {
    return service.post("/nps/submit/question/app", BaseActionResponse.fromJson, body: jsonEncode(body));
  }
}
