// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receive_devices_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiveDevicesResponse _$ReceiveDevicesResponseFromJson(
        Map<String, dynamic> json) =>
    ReceiveDevicesResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..refId = json['r_id'] as String?
      ..isSuccess = json['s'] as bool? ?? false
      ..errorMsg = json['em'] as String?
      ..successMessage = json['sm'] as String?
      ..deviceInfo = json['dt'] == null
          ? null
          : DeviceInfo.fromJson(json['dt'] as Map<String, dynamic>);

Map<String, dynamic> _$ReceiveDevicesResponseToJson(
        ReceiveDevicesResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'r_id': instance.refId,
      's': instance.isSuccess,
      'em': instance.errorMsg,
      'sm': instance.successMessage,
      'dt': instance.deviceInfo,
    };
