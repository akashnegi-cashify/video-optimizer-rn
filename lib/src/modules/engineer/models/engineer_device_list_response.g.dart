// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engineer_device_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EngineerDeviceListResponse _$EngineerDeviceListResponseFromJson(Map<String, dynamic> json) =>
    EngineerDeviceListResponse(
      json['__ca'] == null ? null : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..deviceList =
          (json['dt'] as List<dynamic>?)?.map((e) => EngineerDeviceInfo.fromJson(e as Map<String, dynamic>)).toList()
      ..isSuccess = json['s'] as bool? ?? false;

Map<String, dynamic> _$EngineerDeviceListResponseToJson(EngineerDeviceListResponse instance) => <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.deviceList,
      's': instance.isSuccess,
    };
