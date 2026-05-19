// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_report_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartReportData _$PartReportDataFromJson(Map<String, dynamic> json) =>
    PartReportData()
      ..avgPartCost = (json['avgpc'] as num?)?.toDouble()
      ..avgPartConsumption = (json['avgpcon'] as num?)?.toDouble()
      ..partsAssign = (json['pr'] as num?)?.toInt()
      ..partsConsume = (json['pc'] as num?)?.toInt()
      ..partsReturn = (json['pret'] as num?)?.toInt()
      ..partsRequested = (json['preq'] as num?)?.toInt();

Map<String, dynamic> _$PartReportDataToJson(PartReportData instance) =>
    <String, dynamic>{
      'avgpc': instance.avgPartCost,
      'avgpcon': instance.avgPartConsumption,
      'pr': instance.partsAssign,
      'pc': instance.partsConsume,
      'pret': instance.partsReturn,
      'preq': instance.partsRequested,
    };
