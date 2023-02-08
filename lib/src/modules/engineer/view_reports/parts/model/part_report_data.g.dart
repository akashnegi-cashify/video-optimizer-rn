// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_report_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartReportData _$PartReportDataFromJson(Map<String, dynamic> json) =>
    PartReportData()
      ..avgPartCost = (json['avgpc'] as num?)?.toDouble()
      ..avgPartConsumption = (json['avgpcon'] as num?)?.toDouble()
      ..partsAssign = json['pr'] as int?
      ..partsConsume = json['pc'] as int?
      ..partsReturn = json['pret'] as int?
      ..partsRequested = json['preq'] as int?;

Map<String, dynamic> _$PartReportDataToJson(PartReportData instance) =>
    <String, dynamic>{
      'avgpc': instance.avgPartCost,
      'avgpcon': instance.avgPartConsumption,
      'pr': instance.partsAssign,
      'pc': instance.partsConsume,
      'pret': instance.partsReturn,
      'preq': instance.partsRequested,
    };
