// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elss_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElssPart _$ElssPartFromJson(Map<String, dynamic> json) => ElssPart(
      version: json['_v'] as int? ?? 0,
      action: json['ac'] as String? ?? "Repairable",
      isManualAdded: json['isManualAdded'] as bool? ?? false,
      isPnaSelected: json['isPnaSelected'] as bool? ?? false,
      isVisibleForPna: json['isVisibleForPna'] as bool? ?? false,
      partColour: json['pcl'] as String?,
      partCount: json['pc'] as int?,
      partName: json['pn'] as String?,
      selectedPos: json['selectedPos'] as int? ?? -1,
      sku: json['sku'] as String?,
      actionConstant: json['acc'] as int?,
      quantity: json['qt'] as int?,
      categoryCode: json['cc'] as String?,
      price: json['pr'] as double?,
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
    };
