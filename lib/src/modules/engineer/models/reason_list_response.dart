import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reason_list_response.g.dart';

@JsonSerializable()
class ReasonListResponse extends BaseResponse {
  @JsonKey(name: 'dt')
  Map<String, List<ReasonListData>>? reasonsMap;

  ReasonListResponse(this.reasonsMap, super.cashifyAlert, super.trackUrl);

  static ReasonListResponse fromJson(Map<String, dynamic> json) => _$ReasonListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReasonListResponseToJson(this);
}

@JsonSerializable()
class ReasonListData {
  @JsonKey(name: 'rrid')
  int? reasonId;

  @JsonKey(name: 'reason')
  String? reason;

  @JsonKey(name: 'imr')
  bool? isImageRequired;

  ReasonListData(this.reasonId, this.reason, this.isImageRequired);

  static ReasonListData fromJson(Map<String, dynamic> json) => _$ReasonListDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReasonListDataToJson(this);
}
