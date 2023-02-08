import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';
part 'base_action_response.g.dart';

@JsonSerializable()
class BaseActionResponse extends BaseResponse{

  @JsonKey(name: "r_id")
  String? refId;

  @JsonKey(name: "s", defaultValue: false)
  late bool isSuccess;

  @JsonKey(name: "em")
  String? errorMsg;

  BaseActionResponse(super.cashifyAlert, super.trackUrl);


  static BaseActionResponse fromJson(Map<String, dynamic> json) => _$BaseActionResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BaseActionResponseToJson(this);

}