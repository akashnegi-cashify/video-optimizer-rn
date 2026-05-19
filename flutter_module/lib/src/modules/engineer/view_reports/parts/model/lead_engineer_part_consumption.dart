import 'package:json_annotation/json_annotation.dart';

part 'lead_engineer_part_consumption.g.dart';

@JsonSerializable()
class LeadEngineerPartConsumption {
  @JsonKey(name: "pcon")
  double? partConsumption;

  @JsonKey(name: "en")
  String? engineerName;

  static LeadEngineerPartConsumption fromJson(Map<String, dynamic> data) => _$LeadEngineerPartConsumptionFromJson(data);

  Map<String, dynamic> toJson() => _$LeadEngineerPartConsumptionToJson(this);
}
