// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_remove_part_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddRemovePartResponse _$AddRemovePartResponseFromJson(
        Map<String, dynamic> json) =>
    AddRemovePartResponse(
      status: json['s'] as bool?,
      confirmMessage: json['cm'] as String?,
    );

Map<String, dynamic> _$AddRemovePartResponseToJson(
        AddRemovePartResponse instance) =>
    <String, dynamic>{
      's': instance.status,
      'cm': instance.confirmMessage,
    };
