// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_list_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartListHistoryResponse _$PartListHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    PartListHistoryResponse(
      (json['dt'] as List<dynamic>?)
          ?.map((e) => PartListHistoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$PartListHistoryResponseToJson(
        PartListHistoryResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.partListHistory,
    };

PartListHistoryData _$PartListHistoryDataFromJson(Map<String, dynamic> json) =>
    PartListHistoryData(
      sku: json['sku'] as String?,
      partName: json['pn'] as String?,
      alternatePartName: json['apn'] as String?,
      status: json['st'] as String?,
      statusCode: (json['stc'] as num?)?.toInt(),
      updatedBy: json['updby'] as String?,
      updatedAt: (json['updat'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PartListHistoryDataToJson(
        PartListHistoryData instance) =>
    <String, dynamic>{
      'sku': instance.sku,
      'pn': instance.partName,
      'apn': instance.alternatePartName,
      'st': instance.status,
      'stc': instance.statusCode,
      'updby': instance.updatedBy,
      'updat': instance.updatedAt,
    };
