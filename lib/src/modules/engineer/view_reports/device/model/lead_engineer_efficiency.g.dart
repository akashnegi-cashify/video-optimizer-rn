// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_engineer_efficiency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadEngineerEfficiency _$LeadEngineerEfficiencyFromJson(
        Map<String, dynamic> json) =>
    LeadEngineerEfficiency()
      ..efficieny = (json['meff'] as num?)?.toDouble()
      ..engineerName = json['en'] as String?;

Map<String, dynamic> _$LeadEngineerEfficiencyToJson(
        LeadEngineerEfficiency instance) =>
    <String, dynamic>{
      'meff': instance.efficieny,
      'en': instance.engineerName,
    };
