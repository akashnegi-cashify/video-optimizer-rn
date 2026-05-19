// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_submission_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuditSubmissionResponse _$AuditSubmissionResponseFromJson(
        Map<String, dynamic> json) =>
    AuditSubmissionResponse(
      json['r_id'] as String?,
      json['success'] as bool?,
      json['dt'] == null
          ? null
          : AuditSubmissionResponseData.fromJson(
              json['dt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuditSubmissionResponseToJson(
        AuditSubmissionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'r_id': instance.referenceId,
      'dt': instance.auditSubmissionData,
    };

AuditSubmissionResponseData _$AuditSubmissionResponseDataFromJson(
        Map<String, dynamic> json) =>
    AuditSubmissionResponseData(
      json['r_id'] as String?,
      json['pn'] as String?,
      json['bn'] as String?,
      json['gr'] as String?,
      (json['ps'] as List<dynamic>?)
          ?.map((e) => PartsStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['qa'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AuditSubmissionResponseDataToJson(
        AuditSubmissionResponseData instance) =>
    <String, dynamic>{
      'r_id': instance.referenceId,
      'pn': instance.productName,
      'bn': instance.brandName,
      'qa': instance.qa,
      'gr': instance.grade,
      'ps': instance.partsStatusList,
    };

PartsStatus _$PartsStatusFromJson(Map<String, dynamic> json) => PartsStatus(
      json['l'] as String?,
      json['p'] as String?,
    );

Map<String, dynamic> _$PartsStatusToJson(PartsStatus instance) =>
    <String, dynamic>{
      'l': instance.label,
      'p': instance.p,
    };
