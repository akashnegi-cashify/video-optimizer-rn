// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_device_testing_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckDeviceTestingResponse _$CheckDeviceTestingResponseFromJson(
        Map<String, dynamic> json) =>
    CheckDeviceTestingResponse(
      Map<String, bool>.from(json['dt'] as Map),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$CheckDeviceTestingResponseToJson(
        CheckDeviceTestingResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.response,
    };
