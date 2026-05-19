import 'package:json_annotation/json_annotation.dart';

part 'lead_engineer_part_cost.g.dart';

@JsonSerializable()
class LeadEngineerPartCost {
  @JsonKey(name: "mpc")
  double? partCost;

  @JsonKey(name: "en")
  String? engineerName;

  static LeadEngineerPartCost fromJson(Map<String, dynamic> data) => _$LeadEngineerPartCostFromJson(data);

  Map<String, dynamic> toJson() => _$LeadEngineerPartCostToJson(this);
}
