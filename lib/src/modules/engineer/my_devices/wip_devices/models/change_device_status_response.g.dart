// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_device_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeDeviceStatusResponse _$ChangeDeviceStatusResponseFromJson(
        Map<String, dynamic> json) =>
    ChangeDeviceStatusResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..errorMsg = json['em'] as String?
      ..deviceInfo = json['dt'] == null
          ? null
          : EngineerDeviceInfo.fromJson(json['dt'] as Map<String, dynamic>);

Map<String, dynamic> _$ChangeDeviceStatusResponseToJson(
        ChangeDeviceStatusResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'em': instance.errorMsg,
      'dt': instance.deviceInfo,
    };
