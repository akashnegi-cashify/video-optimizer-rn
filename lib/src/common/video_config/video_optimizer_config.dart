import 'package:json_annotation/json_annotation.dart';

part 'video_optimizer_config.g.dart';

@JsonSerializable()
class VideoOptimizerConfig {
  final int? crf;
  final String? videoCodec;
  final String? videoPreset;
  final bool? addTimeStamp;
  final int? fontSize;
  final String? fontColor;
  final String? borderColor;
  final bool? isRemoveAudio;

  VideoOptimizerConfig({
    this.crf,
    this.videoCodec,
    this.videoPreset,
    this.addTimeStamp,
    this.fontSize,
    this.fontColor,
    this.borderColor,
    this.isRemoveAudio = false,
  });

  static VideoOptimizerConfig fromJson(Map<String, dynamic> data) => _$VideoOptimizerConfigFromJson(data);

  Map<String, dynamic> toJson() => _$VideoOptimizerConfigToJson(this);
}
