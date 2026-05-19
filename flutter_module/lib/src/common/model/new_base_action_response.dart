import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_base_action_response.g.dart';

@JsonSerializable()
class NewBaseActionResponse extends BaseResponse {
  @JsonKey(name: "r_id")
  String? refId;

  @JsonKey(name: "em")
  String? errorMsg;

  @JsonKey(name: "sm")
  String? successMessage;

  NewBaseActionResponse(super.cashifyAlert, super.trackUrl);

  static NewBaseActionResponse fromJson(Map<String, dynamic> json) => _$NewBaseActionResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NewBaseActionResponseToJson(this);
}
