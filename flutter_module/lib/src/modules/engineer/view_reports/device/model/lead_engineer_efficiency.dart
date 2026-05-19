import 'package:json_annotation/json_annotation.dart';

part 'lead_engineer_efficiency.g.dart';

@JsonSerializable()
class LeadEngineerEfficiency {
  @JsonKey(name: "meff")
  double? efficieny;

  @JsonKey(name: "en")
  String? engineerName;

  static LeadEngineerEfficiency fromJson(Map<String, dynamic> json) => _$LeadEngineerEfficiencyFromJson(json);

  Map<String, dynamic> toJson() => _$LeadEngineerEfficiencyToJson(this);
}
