// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_engineer_device_report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadEngineerDeviceReportResponse _$LeadEngineerDeviceReportResponseFromJson(
        Map<String, dynamic> json) =>
    LeadEngineerDeviceReportResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..requestId = json['r_id'] as String?
      ..data = json['dt'] == null
          ? null
          : LeadEngineerData.fromJson(json['dt'] as Map<String, dynamic>);

Map<String, dynamic> _$LeadEngineerDeviceReportResponseToJson(
        LeadEngineerDeviceReportResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'r_id': instance.requestId,
      'dt': instance.data,
    };
