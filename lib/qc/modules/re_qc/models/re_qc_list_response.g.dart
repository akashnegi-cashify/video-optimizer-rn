// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 're_qc_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReQcListResponse _$ReQcListResponseFromJson(Map<String, dynamic> json) =>
    ReQcListResponse(
      (json['dt'] as List<dynamic>?)
          ?.map((e) => ReQcListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$ReQcListResponseToJson(ReQcListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.list,
    };

ReQcListData _$ReQcListDataFromJson(Map<String, dynamic> json) => ReQcListData(
      lotGroupName: json['lotGroupName'] as String?,
      lotCount: (json['lotCount'] as num?)?.toInt(),
      pendingCount: (json['qcPending'] as num?)?.toInt(),
      doneCount: (json['qcDone'] as num?)?.toInt(),
      auditCount: (json['qcAudit'] as num?)?.toInt(),
      lotType: json['lotType'] as String?,
      lotId: (json['id'] as num?)?.toInt(),
      skipReQc: json['skipReQc'] as bool?,
    );

Map<String, dynamic> _$ReQcListDataToJson(ReQcListData instance) =>
    <String, dynamic>{
      'lotGroupName': instance.lotGroupName,
      'lotCount': instance.lotCount,
      'qcPending': instance.pendingCount,
      'qcDone': instance.doneCount,
      'qcAudit': instance.auditCount,
      'lotType': instance.lotType,
      'skipReQc': instance.skipReQc,
      'id': instance.lotId,
    };
