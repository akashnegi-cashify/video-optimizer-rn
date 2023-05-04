// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartSummaryResponse _$PartSummaryResponseFromJson(Map<String, dynamic> json) =>
    PartSummaryResponse(
      isSuccess: json['s'] as bool?,
      refId: json['r_id'] as String?,
      summaryData: json['dt'] == null
          ? null
          : PartSummaryData.fromJson(json['dt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PartSummaryResponseToJson(
        PartSummaryResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      's': instance.isSuccess,
      'dt': instance.summaryData,
    };

PartSummaryData _$PartSummaryDataFromJson(Map<String, dynamic> json) =>
    PartSummaryData(
      assignedCount: json['ac'] as int?,
      pendingCount: json['pdc'] as int?,
    );

Map<String, dynamic> _$PartSummaryDataToJson(PartSummaryData instance) =>
    <String, dynamic>{
      'ac': instance.assignedCount,
      'pdc': instance.pendingCount,
    };
