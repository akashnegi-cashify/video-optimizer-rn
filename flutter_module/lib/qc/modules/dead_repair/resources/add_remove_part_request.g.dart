// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_remove_part_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddRemovePartRequest _$AddRemovePartRequestFromJson(
        Map<String, dynamic> json) =>
    AddRemovePartRequest(
      id: (json['id'] as num?)?.toInt(),
      sku: json['sku'] as String?,
    );

Map<String, dynamic> _$AddRemovePartRequestToJson(
        AddRemovePartRequest instance) =>
    <String, dynamic>{
      'sku': instance.sku,
      'id': instance.id,
    };
