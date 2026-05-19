import 'package:json_annotation/json_annotation.dart';

part 'calculator_question_answer_request.g.dart';

@JsonSerializable()
class CalculatorQuestionAnswerRequest {
  @JsonKey(name: "qId")
  String? questionId;

  @JsonKey(name: "optionId")
  int? answerId;

  @JsonKey(name: "timeStamp")
  String? timeStamp;

  CalculatorQuestionAnswerRequest(this.questionId, this.answerId, this.timeStamp);

  static CalculatorQuestionAnswerRequest fromJson(Map<String, dynamic> json) =>
      _$CalculatorQuestionAnswerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CalculatorQuestionAnswerRequestToJson(this);
}
