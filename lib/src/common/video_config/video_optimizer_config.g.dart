// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_optimizer_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoOptimizerConfig _$VideoOptimizerConfigFromJson(
        Map<String, dynamic> json) =>
    VideoOptimizerConfig(
      crf: json['crf'] as int?,
      videoCodec: json['videoCodec'] as String?,
      videoPreset: json['videoPreset'] as String?,
      addTimeStamp: json['addTimeStamp'] as bool?,
      fontSize: json['fontSize'] as int?,
      fontColor: json['fontColor'] as String?,
      borderColor: json['borderColor'] as String?,
    );

Map<String, dynamic> _$VideoOptimizerConfigToJson(
        VideoOptimizerConfig instance) =>
    <String, dynamic>{
      'crf': instance.crf,
      'videoCodec': instance.videoCodec,
      'videoPreset': instance.videoPreset,
      'addTimeStamp': instance.addTimeStamp,
      'fontSize': instance.fontSize,
      'fontColor': instance.fontColor,
      'borderColor': instance.borderColor,
    };
