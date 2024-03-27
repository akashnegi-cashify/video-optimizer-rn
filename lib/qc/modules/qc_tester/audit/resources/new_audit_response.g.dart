// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_audit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewAuditResponse _$NewAuditResponseFromJson(Map<String, dynamic> json) =>
    NewAuditResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..referenceId = json['r_id'] as String?
      ..auditQuestionResponse = json['dt'] == null
          ? null
          : AuditQuestionResponse.fromJson(json['dt'] as Map<String, dynamic>);

Map<String, dynamic> _$NewAuditResponseToJson(NewAuditResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'r_id': instance.referenceId,
      'dt': instance.auditQuestionResponse,
    };

AuditQuestionResponse _$AuditQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    AuditQuestionResponse()
      ..auditQuestionList = (json['dpr'] as List<dynamic>?)
          ?.map((e) => AuditQuestionData.fromJson(e as Map<String, dynamic>))
          .toList()
      ..manualAuditQuestionList = (json['maq'] as List<dynamic>?)
          ?.map((e) =>
              ManualAuditQuestionItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$AuditQuestionResponseToJson(
        AuditQuestionResponse instance) =>
    <String, dynamic>{
      'dpr': instance.auditQuestionList,
      'maq': instance.manualAuditQuestionList,
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

ManualAuditQuestionItem _$ManualAuditQuestionItemFromJson(
        Map<String, dynamic> json) =>
    ManualAuditQuestionItem(
      json['mmid'] as int?,
      json['q'] as String?,
    )..isSelected = json['is'] as bool?;

Map<String, dynamic> _$ManualAuditQuestionItemToJson(
        ManualAuditQuestionItem instance) =>
    <String, dynamic>{
      'mmid': instance.manualMasterId,
      'q': instance.question,
      'is': instance.isSelected,
    };
