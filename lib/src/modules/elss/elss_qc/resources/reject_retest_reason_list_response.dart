import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reject_retest_reason_list_response.g.dart';

@JsonSerializable()
class RejectRetestReasonListResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<RejectRetestReasonListItem>? reasonList;

  RejectRetestReasonListResponse(super.cashifyAlert, super.trackUrl, this.reasonList);

  static RejectRetestReasonListResponse fromJson(Map<String, dynamic> json) =>
      _$RejectRetestReasonListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RejectRetestReasonListResponseToJson(this);
}

@JsonSerializable()
class RejectRetestReasonListItem {
  @JsonKey(name: "k")
  int? id;

  @JsonKey(name: "v")
  String? label;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool isSelected = false;

  RejectRetestReasonListItem(this.id, this.label);

  static RejectRetestReasonListItem fromJson(Map<String, dynamic> json) => _$RejectRetestReasonListItemFromJson(json);

  Map<String, dynamic> toJson() => _$RejectRetestReasonListItemToJson(this);
}
