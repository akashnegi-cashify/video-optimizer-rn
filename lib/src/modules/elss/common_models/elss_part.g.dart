// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elss_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElssPart _$ElssPartFromJson(Map<String, dynamic> json) => ElssPart(
      version: (json['_v'] as num?)?.toInt() ?? 0,
      action: json['ac'] as String? ?? "Repairable",
      isManualAdded: json['isManualAdded'] as bool? ?? false,
      isPnaSelected: json['isPnaSelected'] as bool? ?? false,
      isVisibleForPna: json['isVisibleForPna'] as bool? ?? false,
      partColour: json['pcl'] as String?,
      partCount: (json['pc'] as num?)?.toInt(),
      partName: json['pn'] as String?,
      selectedPos: (json['selectedPos'] as num?)?.toInt() ?? -1,
      sku: json['sku'] as String?,
      actionConstant: (json['acc'] as num?)?.toInt(),
      quantity: (json['qt'] as num?)?.toInt(),
      categoryCode: json['cc'] as String?,
      price: (json['pr'] as num?)?.toDouble(),
      partVariantName: json['pvn'] as String?,
    );

Map<String, dynamic> _$ElssPartToJson(ElssPart instance) => <String, dynamic>{
      'sku': instance.sku,
      'pn': instance.partName,
      'ac': instance.action,
      'acc': instance.actionConstant,
      'isManualAdded': instance.isManualAdded,
      'pc': instance.partCount,
      'pcl': instance.partColour,
      'isPnaSelected': instance.isPnaSelected,
      'selectedPos': instance.selectedPos,
      'isVisibleForPna': instance.isVisibleForPna,
      'qt': instance.quantity,
      '_v': instance.version,
      'cc': instance.categoryCode,
      'pr': instance.price,
      'pvn': instance.partVariantName,
    };
