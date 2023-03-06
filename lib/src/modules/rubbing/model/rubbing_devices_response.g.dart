// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rubbing_devices_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RubbingDevicesResponse _$RubbingDevicesResponseFromJson(
        Map<String, dynamic> json) =>
    RubbingDevicesResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..rId = json['r_id'] as String
      ..dt = json['dt'] == null
          ? null
          : RubbingListData.fromJson(json['dt'] as Map<String, dynamic>)
      ..s = json['s'] as bool? ?? false;

Map<String, dynamic> _$RubbingDevicesResponseToJson(
        RubbingDevicesResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'r_id': instance.rId,
      'dt': instance.dt,
      's': instance.s,
    };
