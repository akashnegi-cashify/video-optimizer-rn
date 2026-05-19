// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dismantle_device_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DismantleDevice _$DismantleDeviceFromJson(Map<String, dynamic> json) =>
    DismantleDevice(
      deviceId: (json['did'] as num?)?.toInt(),
      deviceBarcode: json['dbr'] as String?,
      model: json['mdl'] as String?,
      statusDescription: json['sd'] as String?,
      engineer: json['eng'] as String?,
      parts: (json['pts'] as List<dynamic>?)
          ?.map((e) => DismantlePart.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DismantleDeviceToJson(DismantleDevice instance) =>
    <String, dynamic>{
      'did': instance.deviceId,
      'dbr': instance.deviceBarcode,
      'mdl': instance.model,
      'sd': instance.statusDescription,
      'eng': instance.engineer,
      'pts': instance.parts,
    };

DismantlePart _$DismantlePartFromJson(Map<String, dynamic> json) =>
    DismantlePart(
      partId: (json['pid'] as num?)?.toInt(),
      partName: json['pn'] as String?,
      barcode: json['bc'] as String?,
    );

Map<String, dynamic> _$DismantlePartToJson(DismantlePart instance) =>
    <String, dynamic>{
      'pid': instance.partId,
      'pn': instance.partName,
      'bc': instance.barcode,
    };
