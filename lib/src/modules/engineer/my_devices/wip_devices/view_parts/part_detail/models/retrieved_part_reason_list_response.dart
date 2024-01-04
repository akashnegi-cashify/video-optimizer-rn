import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'retrieved_part_reason_list_response.g.dart';

@JsonSerializable()
class RetrievedPartReasonListResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<RetrievedPartReasonListData>? reasonList;

  RetrievedPartReasonListResponse(this.reasonList, super.cashifyAlert, super.trackUrl);

  static RetrievedPartReasonListResponse fromJson(Map<String, dynamic> json) =>
      _$RetrievedPartReasonListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RetrievedPartReasonListResponseToJson(this);
}

@JsonSerializable()
class RetrievedPartReasonListData {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "rr")
  String? reason;

  RetrievedPartReasonListData(this.id, this.reason);

  static RetrievedPartReasonListData fromJson(Map<String, dynamic> json) => _$RetrievedPartReasonListDataFromJson(json);

  Map<String, dynamic> toJson() => _$RetrievedPartReasonListDataToJson(this);
}
