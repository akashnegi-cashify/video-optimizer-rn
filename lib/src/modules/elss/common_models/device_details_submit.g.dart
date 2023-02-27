// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_details_submit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceDetailsSubmit _$DeviceDetailsSubmitFromJson(Map<String, dynamic> json) => DeviceDetailsSubmit(
      isSuccess: json['s'] as bool?,
      refId: json['r_id'] as String?,
    );

Map<String, dynamic> _$DeviceDetailsSubmitToJson(DeviceDetailsSubmit instance) => <String, dynamic>{
      'r_id': instance.refId,
      's': instance.isSuccess,
    };
