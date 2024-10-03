// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_engineer_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEngineerPart _$OrderEngineerPartFromJson(Map<String, dynamic> json) =>
    OrderEngineerPart(
      (json['qty'] as num?)?.toInt(),
      version: (json['_v'] as num?)?.toInt() ?? 0,
    )
      ..sku = json['sku'] as String?
      ..partName = json['pn'] as String?
      ..partBarcode = json['pbr'] as String?
      ..deviceName = json['dna'] as String?
      ..deviceBarcode = json['dbr'] as String?
      ..partId = (json['pid'] as num?)?.toInt()
      ..partColor = json['pcl'] as String?
      ..isBulk = json['isBulk'] as bool?
      ..isUrgent = json['isUrgent'] as bool?
      ..prId = (json['prid'] as num?)?.toInt()
      ..isService = json['isService'] as bool?
      ..action = json['ac'] as String?
      ..categoryCode = json['cc'] as String?
      ..partVariantName = json['pvn'] as String?
      ..retrievedPartData = json['rpd'] as Map<String, dynamic>?
      ..status = json['st'] as String?
      ..statusCode = (json['stc'] as num?)?.toInt()
      ..retrievedImageCount = (json['rvc'] as num?)?.toInt()
      ..partType = (json['action'] as num?)?.toInt()
      ..reasonId = (json['rrid'] as num?)?.toInt()
      ..imageList =
          (json['imgs'] as List<dynamic>?)?.map((e) => e as String).toList();

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
      'cc': instance.categoryCode,
      'pvn': instance.partVariantName,
      'rpd': instance.retrievedPartData,
      'st': instance.status,
      'stc': instance.statusCode,
      'rvc': instance.retrievedImageCount,
      'qty': instance.orderQuantity,
      '_v': instance.version,
      'action': instance.partType,
      'rrid': instance.reasonId,
      'imgs': instance.imageList,
    };
