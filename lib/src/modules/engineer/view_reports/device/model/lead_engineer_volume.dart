import 'package:json_annotation/json_annotation.dart';

part 'lead_engineer_volume.g.dart';

@JsonSerializable()
class LeadEngineerVolume {
  @JsonKey(name: "mv")
  int? volume;

  @JsonKey(name: "en")
  String? engineerName;

  static LeadEngineerVolume fromJson(Map<String, dynamic> json) => _$LeadEngineerVolumeFromJson(json);

  Map<String, dynamic> toJson() => _$LeadEngineerVolumeToJson(this);
}
