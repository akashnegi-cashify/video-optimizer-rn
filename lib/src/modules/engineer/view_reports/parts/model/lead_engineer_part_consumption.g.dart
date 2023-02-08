// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_engineer_part_consumption.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadEngineerPartConsumption _$LeadEngineerPartConsumptionFromJson(
        Map<String, dynamic> json) =>
    LeadEngineerPartConsumption()
      ..partConsumption = (json['pcon'] as num?)?.toDouble()
      ..engineerName = json['en'] as String?;

Map<String, dynamic> _$LeadEngineerPartConsumptionToJson(
        LeadEngineerPartConsumption instance) =>
    <String, dynamic>{
      'pcon': instance.partConsumption,
      'en': instance.engineerName,
    };
