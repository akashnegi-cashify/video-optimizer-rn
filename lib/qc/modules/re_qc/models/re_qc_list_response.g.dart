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
      lotGroupName: json['lgn'] as String?,
      lotCount: (json['lc'] as num?)?.toInt(),
      pendingCount: (json['pc'] as num?)?.toInt(),
      doneCount: (json['dc'] as num?)?.toInt(),
      auditCount: (json['ac'] as num?)?.toInt(),
      lotType: json['lt'] as String?,
      skipReQc: json['srqc'] as bool?,
    );

Map<String, dynamic> _$ReQcListDataToJson(ReQcListData instance) =>
    <String, dynamic>{
      'lgn': instance.lotGroupName,
      'lc': instance.lotCount,
      'pc': instance.pendingCount,
      'dc': instance.doneCount,
      'ac': instance.auditCount,
      'lt': instance.lotType,
      'srqc': instance.skipReQc,
    };
