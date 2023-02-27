// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_engineer_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadEngineerData _$LeadEngineerDataFromJson(Map<String, dynamic> json) => LeadEngineerData()
  ..leadEngineerPartCost =
      json['lpc'] == null ? null : LeadEngineerPartCost.fromJson(json['lpc'] as Map<String, dynamic>)
  ..leadEngineerPartConsumption =
      json['lpcon'] == null ? null : LeadEngineerPartConsumption.fromJson(json['lpcon'] as Map<String, dynamic>);

Map<String, dynamic> _$LeadEngineerDataToJson(LeadEngineerData instance) => <String, dynamic>{
      'lpc': instance.leadEngineerPartCost,
      'lpcon': instance.leadEngineerPartConsumption,
    };
