// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nps_question_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NpsQuestionResponse _$NpsQuestionResponseFromJson(Map<String, dynamic> json) =>
    NpsQuestionResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )..npsResponse = json['dt'] == null
        ? null
        : NpsResponseData.fromJson(json['dt'] as Map<String, dynamic>);

Map<String, dynamic> _$NpsQuestionResponseToJson(
        NpsQuestionResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.npsResponse,
    };

NpsResponseData _$NpsResponseDataFromJson(Map<String, dynamic> json) =>
    NpsResponseData()
      ..questionList = (json['questions'] as List<dynamic>?)
          ?.map((e) => NpsQuestionData.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$NpsResponseDataToJson(NpsResponseData instance) =>
    <String, dynamic>{
      'questions': instance.questionList,
    };

NpsQuestionData _$NpsQuestionDataFromJson(Map<String, dynamic> json) =>
    NpsQuestionData(
      (json['questionId'] as num?)?.toInt(),
      json['statement'] as String?,
      json['questionTypekey'] as String?,
      json['questionTypeTitle'] as String?,
      (json['questionOptions'] as List<dynamic>?)
          ?.map((e) => NpsQuestionData.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$NpsQuestionDataToJson(NpsQuestionData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionId': instance.questionId,
      'statement': instance.statement,
      'questionTypekey': instance.questionTypeKey,
      'questionTypeTitle': instance.questionTypeTitle,
      'questionOptions': instance.questionOptions,
    };
