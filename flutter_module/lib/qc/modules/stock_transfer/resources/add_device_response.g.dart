// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_device_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddDeviceResponse _$AddDeviceResponseFromJson(Map<String, dynamic> json) =>
    AddDeviceResponse(
      json['rs'] as bool?,
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$AddDeviceResponseToJson(AddDeviceResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'rs': instance.isReset,
    };
