// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engineer_device_report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EngineerDeviceReportResponse _$EngineerDeviceReportResponseFromJson(
        Map<String, dynamic> json) =>
    EngineerDeviceReportResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..refId = json['r_id'] as String?
      ..isSuccess = json['s'] as bool? ?? false
      ..errorMsg = json['em'] as String?
      ..successMessage = json['sm'] as String?
      ..data = json['dt'] == null
          ? null
          : DeviceReportData.fromJson(json['dt'] as Map<String, dynamic>);

Map<String, dynamic> _$EngineerDeviceReportResponseToJson(
        EngineerDeviceReportResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'r_id': instance.refId,
      's': instance.isSuccess,
      'em': instance.errorMsg,
      'sm': instance.successMessage,
      'dt': instance.data,
    };
