// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_colors_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceColorResponse _$DeviceColorResponseFromJson(Map<String, dynamic> json) =>
    DeviceColorResponse(
      (json['color'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['strapColor'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$DeviceColorResponseToJson(
        DeviceColorResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'color': instance.deviceColorList,
      'strapColor': instance.strapColorList,
    };
