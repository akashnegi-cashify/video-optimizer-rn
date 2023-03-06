// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_engineer_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadEngineerData _$LeadEngineerDataFromJson(Map<String, dynamic> json) =>
    LeadEngineerData()
      ..leadEngineerEfficiency = json['leff'] == null
          ? null
          : LeadEngineerEfficiency.fromJson(
              json['leff'] as Map<String, dynamic>)
      ..leadEngineerAvgRepairTime = json['lrt'] == null
          ? null
          : LeadEngineerAvgRepairTime.fromJson(
              json['lrt'] as Map<String, dynamic>)
      ..leadEngineerVolume = json['lv'] == null
          ? null
          : LeadEngineerVolume.fromJson(json['lv'] as Map<String, dynamic>);

Map<String, dynamic> _$LeadEngineerDataToJson(LeadEngineerData instance) =>
    <String, dynamic>{
      'leff': instance.leadEngineerEfficiency,
      'lrt': instance.leadEngineerAvgRepairTime,
      'lv': instance.leadEngineerVolume,
    };
