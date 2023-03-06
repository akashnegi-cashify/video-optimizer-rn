import 'package:json_annotation/json_annotation.dart';

import 'lead_engineer_avg_repair_time.dart';
import 'lead_engineer_efficiency.dart';
import 'lead_engineer_volume.dart';
part 'lead_engineer_data.g.dart';

@JsonSerializable()
class LeadEngineerData {
  @JsonKey(name: "leff")
  LeadEngineerEfficiency? leadEngineerEfficiency;

  @JsonKey(name: "lrt")
  LeadEngineerAvgRepairTime? leadEngineerAvgRepairTime;

  @JsonKey(name: "lv")
  LeadEngineerVolume? leadEngineerVolume;

  static LeadEngineerData fromJson(Map<String, dynamic> json) => _$LeadEngineerDataFromJson(json);

  Map<String, dynamic> toJson() => _$LeadEngineerDataToJson(this);
}
