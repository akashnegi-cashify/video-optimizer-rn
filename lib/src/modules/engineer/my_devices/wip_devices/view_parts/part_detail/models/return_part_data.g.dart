// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_part_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnPartData _$ReturnPartDataFromJson(Map<String, dynamic> json) =>
    ReturnPartData(
      json['pbr'] as String?,
      json['pid'] as String?,
      json['rr'] as String?,
      json['remark'] as String?,
      json['prid'] as int?,
    );

Map<String, dynamic> _$ReturnPartDataToJson(ReturnPartData instance) =>
    <String, dynamic>{
      'pbr': instance.partBarcode,
      'pid': instance.partId,
      'rr': instance.returnReason,
      'remark': instance.remark,
      'prid': instance.prid,
    };
