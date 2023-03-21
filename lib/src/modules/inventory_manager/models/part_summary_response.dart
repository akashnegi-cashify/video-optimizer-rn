import 'package:json_annotation/json_annotation.dart';
part 'part_summary_response.g.dart';

@JsonSerializable()
class PartSummaryResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "dt")
  PartSummaryData? summaryData;

  PartSummaryResponse({
    this.isSuccess,
    this.refId,
    this.summaryData,
  });

  static PartSummaryResponse fromJson(Map<String, dynamic> data) => _$PartSummaryResponseFromJson(data);

  Map<String, dynamic> toJson() => _$PartSummaryResponseToJson(this);
}

@JsonSerializable()
class PartSummaryData {
  @JsonKey(name: "ac")
  int? assignedCount;
  @JsonKey(name: "pdc")
  int? pendingCount;

  PartSummaryData({
    this.assignedCount,
    this.pendingCount,
  });

  static PartSummaryData fromJson(Map<String, dynamic> data) => _$PartSummaryDataFromJson(data);

  Map<String, dynamic> toJson() => _$PartSummaryDataToJson(this);
}
