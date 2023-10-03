// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manual_question_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManualQuestionListResponse _$ManualQuestionListResponseFromJson(
        Map<String, dynamic> json) =>
    ManualQuestionListResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
      (json['dt'] as List<dynamic>?)
          ?.map(
              (e) => ManualQuestionListData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ManualQuestionListResponseToJson(
        ManualQuestionListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.questionList,
    };

ManualQuestionListData _$ManualQuestionListDataFromJson(
        Map<String, dynamic> json) =>
    ManualQuestionListData(
      json['q'] as String?,
    )..value = json['a'] as int?;

Map<String, dynamic> _$ManualQuestionListDataToJson(
        ManualQuestionListData instance) =>
    <String, dynamic>{
      'q': instance.question,
      'a': instance.value,
    };
