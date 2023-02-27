// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevicePart _$DevicePartFromJson(Map<String, dynamic> json) => DevicePart()
  ..sku = json['sku'] as String?
  ..partName = json['pn'] as String?
  ..partBarcode = json['pbr'] as String?
  ..deviceName = json['dna'] as String?
  ..deviceBarcode = json['dbr'] as String?
  ..partId = json['pid'] as int?
  ..partColor = json['pcl'] as String?
  ..isBulk = json['isBulk'] as bool?
  ..isUrgent = json['isUrgent'] as bool?
  ..prId = json['prid'] as int?;

Map<String, dynamic> _$DevicePartToJson(DevicePart instance) => <String, dynamic>{
      'sku': instance.sku,
      'pn': instance.partName,
      'pbr': instance.partBarcode,
      'dna': instance.deviceName,
      'dbr': instance.deviceBarcode,
      'pid': instance.partId,
      'pcl': instance.partColor,
      'isBulk': instance.isBulk,
      'isUrgent': instance.isUrgent,
      'prid': instance.prId,
    };
