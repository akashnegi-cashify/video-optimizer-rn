// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engineer_part_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EngineerPartInfo _$EngineerPartInfoFromJson(Map<String, dynamic> json) =>
    EngineerPartInfo()
      ..sku = json['sku'] as String?
      ..partName = json['pn'] as String?
      ..partBarcode = json['pbr'] as String?
      ..deviceName = json['dna'] as String?
      ..deviceBarcode = json['dbr'] as String?
      ..partId = json['pid'] as int?
      ..partColor = json['pcl'] as String?
      ..isBulk = json['isBulk'] as bool?
      ..isUrgent = json['isUrgent'] as bool?
      ..prId = json['prid'] as int?
      ..status = json['st'] as String?
      ..statusCode = json['stc'] as int?;

Map<String, dynamic> _$EngineerPartInfoToJson(EngineerPartInfo instance) =>
    <String, dynamic>{
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
      'st': instance.status,
      'stc': instance.statusCode,
    };
