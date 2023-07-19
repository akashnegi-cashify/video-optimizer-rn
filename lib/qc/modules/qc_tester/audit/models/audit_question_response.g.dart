// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_question_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuditQuestionResponse _$AuditQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    AuditQuestionResponse(
      json['tc'] as int?,
      json['pm'] as int?,
      json['r_id'] as String?,
      (json['dt'] as List<dynamic>?)
          ?.map((e) => AuditQuestionData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['ic'] as int?,
      json['message'] as String?,
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$AuditQuestionResponseToJson(
        AuditQuestionResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'r_id': instance.referenceId,
      'tc': instance.totalCount,
      'pm': instance.pm,
      'dt': instance.questionList,
      'ic': instance.isCompleted,
      'message': instance.message,
    };

AuditQuestionData _$AuditQuestionDataFromJson(Map<String, dynamic> json) =>
    AuditQuestionData(
      json['pi'] as int?,
      json['pn'] as String?,
      (json['v'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    )..imageCount = json['ic'] as int?;

Map<String, dynamic> _$AuditQuestionDataToJson(AuditQuestionData instance) =>
    <String, dynamic>{
      'pi': instance.questionId,
      'pn': instance.question,
      'ic': instance.imageCount,
      'v': instance.options,
    };
