// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_receive_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartReceiveResponse _$PartReceiveResponseFromJson(Map<String, dynamic> json) => PartReceiveResponse()
  ..rid = json['r_id'] as String?
  ..success = json['s'] as bool? ?? false;

Map<String, dynamic> _$PartReceiveResponseToJson(PartReceiveResponse instance) => <String, dynamic>{
      'r_id': instance.rid,
      's': instance.success,
    };
