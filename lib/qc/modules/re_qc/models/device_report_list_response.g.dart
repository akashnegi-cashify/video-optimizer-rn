// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_report_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceReportListResponse _$DeviceReportListResponseFromJson(
        Map<String, dynamic> json) =>
    DeviceReportListResponse(
      (json['dt'] as List<dynamic>?)
          ?.map((e) => DeviceReportListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$DeviceReportListResponseToJson(
        DeviceReportListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.deviceReportList,
    };

DeviceReportListData _$DeviceReportListDataFromJson(
        Map<String, dynamic> json) =>
    DeviceReportListData(
      partId: (json['partId'] as num?)?.toInt(),
      label: json['partName'] as String?,
      imageCount: (json['imageCount'] as num?)?.toInt(),
      preSelectedVariantId: (json['selectedVariationId'] as num?)?.toInt(),
      preSelectedVariantName: json['selectedVariationName'] as String?,
      variation: (json['value'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$DeviceReportListDataToJson(
        DeviceReportListData instance) =>
    <String, dynamic>{
      'partId': instance.partId,
      'partName': instance.label,
      'imageCount': instance.imageCount,
      'selectedVariationId': instance.preSelectedVariantId,
      'selectedVariationName': instance.preSelectedVariantName,
      'value': instance.variation,
    };
