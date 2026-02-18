// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_engineer_volume.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadEngineerVolume _$LeadEngineerVolumeFromJson(Map<String, dynamic> json) =>
    LeadEngineerVolume()
      ..volume = (json['mv'] as num?)?.toInt()
      ..engineerName = json['en'] as String?;

Map<String, dynamic> _$LeadEngineerVolumeToJson(LeadEngineerVolume instance) =>
    <String, dynamic>{
      'mv': instance.volume,
      'en': instance.engineerName,
    };
