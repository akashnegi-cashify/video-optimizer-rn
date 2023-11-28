// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_engineer_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEngineerPart _$OrderEngineerPartFromJson(Map<String, dynamic> json) =>
    OrderEngineerPart(
      json['qty'] as int?,
      version: json['_v'] as int? ?? 0,
    )
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
      ..isService = json['isService'] as bool?
      ..action = json['ac'] as String?
      ..status = json['st'] as String?
      ..statusCode = json['stc'] as int?
      ..partType = json['action'] as int?;

Map<String, dynamic> _$OrderEngineerPartToJson(OrderEngineerPart instance) =>
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
      'isService': instance.isService,
      'ac': instance.action,
      'st': instance.status,
      'stc': instance.statusCode,
      'qty': instance.orderQuantity,
      '_v': instance.version,
      'action': instance.partType,
    };
