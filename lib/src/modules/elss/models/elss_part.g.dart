// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elss_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElssPart _$ElssPartFromJson(Map<String, dynamic> json) => ElssPart(
      version: json['_v'] as int? ?? 0,
      action: json['ac'] as String?,
      isManualAdded: json['isManualAdded'] as bool?,
      isPnaSelected: json['isPnaSelected'] as bool? ?? false,
      isVisibleForPna: json['isVisibleForPna'] as bool? ?? false,
      partColour: json['pcl'] as String?,
      partCount: json['pc'] as int?,
      partName: json['pn'] as String?,
      selectedPos: json['selectedPos'] as int? ?? -1,
      sku: json['sku'] as String?,
    );

Map<String, dynamic> _$ElssPartToJson(ElssPart instance) => <String, dynamic>{
      'sku': instance.sku,
      'pn': instance.partName,
      'ac': instance.action,
      'isManualAdded': instance.isManualAdded,
      'pc': instance.partCount,
      'pcl': instance.partColour,
      'isPnaSelected': instance.isPnaSelected,
      'selectedPos': instance.selectedPos,
      'isVisibleForPna': instance.isVisibleForPna,
      '_v': instance.version,
    };
