// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elss_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElssPart _$ElssPartFromJson(Map<String, dynamic> json) => ElssPart(
      version: (json['_v'] as num?)?.toInt() ?? 0,
      action: json['action'] as String? ?? "Repairable",
      isManualAdded: json['isManualAdded'] as bool? ?? false,
      isPnaSelected: json['isPnaSelected'] as bool? ?? false,
      isVisibleForPna: json['isVisibleForPna'] as bool? ?? false,
      partColour: json['partColor'] as String?,
      partCount: (json['partCount'] as num?)?.toInt(),
      partName: json['partName'] as String?,
      selectedPos: (json['selectedPos'] as num?)?.toInt() ?? -1,
      sku: json['sku'] as String?,
      actionConstant: (json['actionCode'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      categoryCode: json['categoryCode'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      partVariantName: json['partVariantName'] as String?,
    );

Map<String, dynamic> _$ElssPartToJson(ElssPart instance) => <String, dynamic>{
      'sku': instance.sku,
      'partName': instance.partName,
      'action': instance.action,
      'actionCode': instance.actionConstant,
      'isManualAdded': instance.isManualAdded,
      'partCount': instance.partCount,
      'partColor': instance.partColour,
      'isPnaSelected': instance.isPnaSelected,
      'selectedPos': instance.selectedPos,
      'isVisibleForPna': instance.isVisibleForPna,
      'quantity': instance.quantity,
      '_v': instance.version,
      'categoryCode': instance.categoryCode,
      'price': instance.price,
      'partVariantName': instance.partVariantName,
    };
