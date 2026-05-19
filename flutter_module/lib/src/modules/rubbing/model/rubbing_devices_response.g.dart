// coverage:ignore-file
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
      ..rId = json['r_id'] as String?
      ..dt = json['data'] == null
          ? null
          : RubbingListData.fromJson(json['data'])
      ..hasNext = json['hasNext'] as bool?
      ..s = json['s'] as bool? ?? false;

Map<String, dynamic> _$RubbingDevicesResponseToJson(
        RubbingDevicesResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'r_id': instance.rId,
      'data': instance.dt,
      'hasNext': instance.hasNext,
      's': instance.s,
    };
