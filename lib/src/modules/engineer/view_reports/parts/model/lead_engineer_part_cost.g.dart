// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_engineer_part_cost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadEngineerPartCost _$LeadEngineerPartCostFromJson(
        Map<String, dynamic> json) =>
    LeadEngineerPartCost()
      ..partCost = (json['mpc'] as num?)?.toDouble()
      ..engineerName = json['en'] as String?;

Map<String, dynamic> _$LeadEngineerPartCostToJson(
        LeadEngineerPartCost instance) =>
    <String, dynamic>{
      'mpc': instance.partCost,
      'en': instance.engineerName,
    };
