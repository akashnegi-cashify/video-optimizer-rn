import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_card_summary_response.g.dart';

@JsonSerializable()
class JobCardSummaryResponse extends BaseResponse {
  @JsonKey(name: "dt")
  JobCardSummary? summary;

  JobCardSummaryResponse(this.summary, super.cashifyAlert, super.trackUrl);

  static JobCardSummaryResponse fromJson(Map<String, dynamic> json) => _$JobCardSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$JobCardSummaryResponseToJson(this);
}

@JsonSerializable()
class JobCardSummary {
  @JsonKey(name: "ps")
  List<JobCardItem>? jobCardList;

  JobCardSummary(this.jobCardList);

  static JobCardSummary fromJson(Map<String, dynamic> json) => _$JobCardSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$JobCardSummaryToJson(this);
}

@JsonSerializable()
class JobCardItem {
  @JsonKey(name: "pn")
  String? partName;

  @JsonKey(name: "pa")
  String? partActionAbbreviation;

  JobCardItem(this.partName, this.partActionAbbreviation);

  static JobCardItem fromJson(Map<String, dynamic> json) => _$JobCardItemFromJson(json);

  Map<String, dynamic> toJson() => _$JobCardItemToJson(this);
}
