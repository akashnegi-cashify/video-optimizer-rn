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
      partId: json['pi'] as int?,
      label: json['pn'] as String?,
      imageCount: json['ic'] as int?,
      selectedVariantId: json['svi'] as int?,
      selectedVariantName: json['svn'] as String?,
      variation: (json['v'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$DeviceReportListDataToJson(
        DeviceReportListData instance) =>
    <String, dynamic>{
      'pi': instance.partId,
      'pn': instance.label,
      'ic': instance.imageCount,
      'svi': instance.selectedVariantId,
      'svn': instance.selectedVariantName,
      'v': instance.variation,
    };
