import 'package:json_annotation/json_annotation.dart';

part 'lead_engineer_avg_repair_time.g.dart';

@JsonSerializable()
class LeadEngineerAvgRepairTime {
  @JsonKey(name: "mrt")
  double? repairTime;

  @JsonKey(name: "en")
  String? engineerName;

  static LeadEngineerAvgRepairTime fromJson(Map<String, dynamic> json) => _$LeadEngineerAvgRepairTimeFromJson(json);

  Map<String, dynamic> toJson() => _$LeadEngineerAvgRepairTimeToJson(this);
}
