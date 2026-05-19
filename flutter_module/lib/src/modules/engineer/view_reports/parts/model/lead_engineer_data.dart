import 'package:json_annotation/json_annotation.dart';

import 'lead_engineer_part_consumption.dart';
import 'lead_engineer_part_cost.dart';

part 'lead_engineer_data.g.dart';

@JsonSerializable()
class LeadEngineerData {
  @JsonKey(name: "lpc")
  LeadEngineerPartCost? leadEngineerPartCost;

  @JsonKey(name: "lpcon")
  LeadEngineerPartConsumption? leadEngineerPartConsumption;

  static LeadEngineerData fromJson(Map<String, dynamic> data) => _$LeadEngineerDataFromJson(data);

  Map<String, dynamic> toJson() => _$LeadEngineerDataToJson(this);
}
