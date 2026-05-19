// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_engineer_avg_repair_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadEngineerAvgRepairTime _$LeadEngineerAvgRepairTimeFromJson(
        Map<String, dynamic> json) =>
    LeadEngineerAvgRepairTime()
      ..repairTime = (json['mrt'] as num?)?.toDouble()
      ..engineerName = json['en'] as String?;

Map<String, dynamic> _$LeadEngineerAvgRepairTimeToJson(
        LeadEngineerAvgRepairTime instance) =>
    <String, dynamic>{
      'mrt': instance.repairTime,
      'en': instance.engineerName,
    };
