// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ongoing_audit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnGoingAuditResponse _$OnGoingAuditResponseFromJson(
        Map<String, dynamic> json) =>
    OnGoingAuditResponse(
      (json['data'] as List<dynamic>?)
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
      'data': instance.onGoingAuditList,
    };

OnGoingAuditData _$OnGoingAuditDataFromJson(Map<String, dynamic> json) =>
    OnGoingAuditData(
      (json['id'] as num?)?.toInt(),
      json['facilityName'] as String?,
      (json['status'] as num?)?.toInt(),
      json['statusDesc'] as String?,
      json['remark'] as String?,
      (json['startDate'] as num?)?.toDouble(),
      (json['endDate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OnGoingAuditDataToJson(OnGoingAuditData instance) =>
    <String, dynamic>{
      'id': instance.auditId,
      'facilityName': instance.facilityName,
      'status': instance.status,
      'statusDesc': instance.statusDescription,
      'remark': instance.message,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };
