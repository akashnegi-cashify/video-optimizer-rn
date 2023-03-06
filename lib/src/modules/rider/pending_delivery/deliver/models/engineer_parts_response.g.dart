// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engineer_parts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EngineerPartsResponse _$EngineerPartsResponseFromJson(
        Map<String, dynamic> json) =>
    EngineerPartsResponse()
      ..rid = json['r_id'] as String?
      ..success = json['s'] as bool? ?? false
      ..parts = (json['dt'] as List<dynamic>?)
          ?.map((e) => Part.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$EngineerPartsResponseToJson(
        EngineerPartsResponse instance) =>
    <String, dynamic>{
      'r_id': instance.rid,
      's': instance.success,
      'dt': instance.parts,
    };
