// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ongoing_audit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnGoingAuditResponse _$OnGoingAuditResponseFromJson(
        Map<String, dynamic> json) =>
    OnGoingAuditResponse(
      (json['dt'] as List<dynamic>?)
          ?.map((e) => OnGoingAuditData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$OnGoingAuditResponseToJson(
        OnGoingAuditResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.onGoingAuditList,
    };

OnGoingAuditData _$OnGoingAuditDataFromJson(Map<String, dynamic> json) =>
    OnGoingAuditData(
      json['aid'] as int?,
      json['fn'] as String?,
      json['s'] as int?,
      json['std'] as String?,
      json['rm'] as String?,
      (json['sd'] as num?)?.toDouble(),
      (json['ed'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OnGoingAuditDataToJson(OnGoingAuditData instance) =>
    <String, dynamic>{
      'aid': instance.auditId,
      'fn': instance.facilityName,
      's': instance.status,
      'std': instance.statusDescription,
      'rm': instance.message,
      'sd': instance.startDate,
      'ed': instance.endDate,
    };
