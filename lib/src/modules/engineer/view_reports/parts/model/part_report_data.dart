import 'package:json_annotation/json_annotation.dart';

part 'part_report_data.g.dart';

@JsonSerializable()
class PartReportData {
  @JsonKey(name: "avgpc")
  double? avgPartCost;
  @JsonKey(name: "avgpcon")
  double? avgPartConsumption;
  @JsonKey(name: "pr")
  int? partsAssign;
  @JsonKey(name: "pc")
  int? partsConsume;
  @JsonKey(name: "pret")
  int? partsReturn;
  @JsonKey(name: "preq")
  int? partsRequested;

  static PartReportData fromJson(Map<String, dynamic> json) => _$PartReportDataFromJson(json);

  Map<String, dynamic> toJson() => _$PartReportDataToJson(this);
}
