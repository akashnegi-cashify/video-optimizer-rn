// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceReportResponse _$DeviceReportResponseFromJson(
        Map<String, dynamic> json) =>
    DeviceReportResponse(
      json['dt'] == null
          ? null
          : DeviceReportData.fromJson(json['dt'] as Map<String, dynamic>),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$DeviceReportResponseToJson(
        DeviceReportResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.deviceReportData,
    };

DeviceReportData _$DeviceReportDataFromJson(Map<String, dynamic> json) =>
    DeviceReportData(
      (json['dr'] as List<dynamic>?)
          ?.map((e) => DeviceReport.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['tr'] as String?,
    );

Map<String, dynamic> _$DeviceReportDataToJson(DeviceReportData instance) =>
    <String, dynamic>{
      'dr': instance.deviceReportList,
      'tr': instance.testingRemarks,
    };

DeviceReport _$DeviceReportFromJson(Map<String, dynamic> json) => DeviceReport(
      json['pn'] as String?,
      json['vn'] as String?,
      (json['id'] as num?)?.toInt(),
      json['isFail'] as bool?,
    );

Map<String, dynamic> _$DeviceReportToJson(DeviceReport instance) =>
    <String, dynamic>{
      'pn': instance.partName,
      'vn': instance.variationName,
      'id': instance.id,
      'isFail': instance.isFail,
    };
