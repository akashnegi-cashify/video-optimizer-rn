// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engineer_action_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EngineerActionResponse _$EngineerActionResponseFromJson(
        Map<String, dynamic> json) =>
    EngineerActionResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..isSuccess = json['s'] as bool
      ..errorMsg = json['em'] as String?
      ..deviceInfo = json['dt'] == null
          ? null
          : EngineerDeviceInfo.fromJson(json['dt'] as Map<String, dynamic>);

Map<String, dynamic> _$EngineerActionResponseToJson(
        EngineerActionResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      's': instance.isSuccess,
      'em': instance.errorMsg,
      'dt': instance.deviceInfo,
    };
