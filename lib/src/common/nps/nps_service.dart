import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/common/nps/resources/nps_question_response.dart';

class NpsService {
  static Stream<NpsQuestionResponse> getNpsQuestions({required BaseService service}) {
    return service.get("/nps/init/question", NpsQuestionResponse.fromJson);
  }

  static Stream<BaseActionResponse> submitNpsQuestions(Map<String, dynamic> body, {required BaseService service}) {
    return service.post("/nps/submit/question", BaseActionResponse.fromJson, body: jsonEncode(body));
  }
}
