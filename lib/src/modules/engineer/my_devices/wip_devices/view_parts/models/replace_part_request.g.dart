// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replace_part_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplacePartRequest _$ReplacePartRequestFromJson(Map<String, dynamic> json) =>
    ReplacePartRequest(
      json['pbr'] as String?,
      json['pdbr'] as String?,
      json['ndbr'] as String?,
    );

Map<String, dynamic> _$ReplacePartRequestToJson(ReplacePartRequest instance) =>
    <String, dynamic>{
      'pbr': instance.partBarcode,
      'pdbr': instance.previousDeviceBarCode,
      'ndbr': instance.newDeviceBarCode,
    };
