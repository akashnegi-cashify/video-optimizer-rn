// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_mark_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceMarkResponse _$DeviceMarkResponseFromJson(Map<String, dynamic> json) =>
    DeviceMarkResponse(
      success: json['success'] as bool?,
      status: json['s'] as bool?,
      message: json['message'] as String?,
      confirmMessage: json['cm'] as String?,
    );

Map<String, dynamic> _$DeviceMarkResponseToJson(DeviceMarkResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      's': instance.status,
      'message': instance.message,
      'cm': instance.confirmMessage,
    };
