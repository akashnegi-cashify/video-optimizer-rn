// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculator_question_answer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalculatorQuestionAnswerRequest _$CalculatorQuestionAnswerRequestFromJson(
        Map<String, dynamic> json) =>
    CalculatorQuestionAnswerRequest(
      json['qId'] as String?,
      (json['optionId'] as num?)?.toInt(),
      json['timeStamp'] as String?,
    );

Map<String, dynamic> _$CalculatorQuestionAnswerRequestToJson(
        CalculatorQuestionAnswerRequest instance) =>
    <String, dynamic>{
      'qId': instance.questionId,
      'optionId': instance.answerId,
      'timeStamp': instance.timeStamp,
    };
