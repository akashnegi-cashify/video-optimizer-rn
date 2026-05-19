// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_dead_repair_reason_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceDeadRepairReasonListResponse _$DeviceDeadRepairReasonListResponseFromJson(
        Map<String, dynamic> json) =>
    DeviceDeadRepairReasonListResponse(
      data: (json['dt'] as List<dynamic>?)?.map((e) => e as String?).toList(),
    )
      ..success = json['success'] as bool?
      ..status = (json['s'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$DeviceDeadRepairReasonListResponseToJson(
        DeviceDeadRepairReasonListResponse instance) =>
    <String, dynamic>{
      'dt': instance.data,
      'success': instance.success,
      's': instance.status,
      'message': instance.message,
    };
