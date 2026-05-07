import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mark_to_tl_reasons_response.g.dart';

@JsonSerializable()
class MarkToTlReasonsResponse extends BaseResponse {
  @JsonKey(name: "isSuccess", defaultValue: false)
  late bool isSuccess;

  @JsonKey(name: "responseData")
  List<MarkToTlReason>? responseData;

  MarkToTlReasonsResponse(super.cashifyAlert, super.trackUrl);

  static MarkToTlReasonsResponse fromJson(Map<String, dynamic> json) => _$MarkToTlReasonsResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MarkToTlReasonsResponseToJson(this);
}

@JsonSerializable()
class MarkToTlReason {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "rsn")
  String? reason;

  MarkToTlReason({this.id, this.reason});

  static MarkToTlReason fromJson(Map<String, dynamic> json) => _$MarkToTlReasonFromJson(json);

  Map<String, dynamic> toJson() => _$MarkToTlReasonToJson(this);
}
