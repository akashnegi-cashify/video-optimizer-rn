import 'package:flutter_trc/src/common/nps/resources/nps_question_response.dart';
import 'package:flutter_trc/src/common/nps/resources/nps_question_type.dart';

class NpsSelectedValue {
  final String npsQuestionType;
  dynamic _npsValue;

  NpsSelectedValue(this.npsQuestionType);

  dynamic get npsValue => _npsValue;

  set npsValue(dynamic value) {
    if (npsQuestionType == NpsQuestionType.rating.value) {
      if (value is NpsQuestionData) {
        _npsValue = [value.id];
      } else {
        throw Exception("Invalid value type for rating question");
      }
    } else if (npsQuestionType == NpsQuestionType.text.value) {
      if (value is String) {
        _npsValue = value;
      } else {
        throw Exception("Invalid value type for text question");
      }
    }
  }
}
