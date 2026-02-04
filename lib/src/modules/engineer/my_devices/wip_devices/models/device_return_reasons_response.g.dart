// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_return_reasons_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceReturnReasonsResponse _$DeviceReturnReasonsResponseFromJson(
        Map<String, dynamic> json) =>
    DeviceReturnReasonsResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..rId = json['r_id'] as String
      ..isSuccess = json['s'] as bool
      ..errorMsg = json['em'] as String?
      ..reasons = (json['dt'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$DeviceReturnReasonsResponseToJson(
        DeviceReturnReasonsResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'r_id': instance.rId,
      's': instance.isSuccess,
      'em': instance.errorMsg,
      'dt': instance.reasons,
    };
