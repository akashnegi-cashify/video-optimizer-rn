import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';
part 'base_action_response.g.dart';

@JsonSerializable()
class BaseActionResponse extends BaseResponse {
  @JsonKey(name: "r_id")
  String? refId;

  @JsonKey(name: "s", defaultValue: false)
  late bool isSuccess;

  @JsonKey(name: "em")
  String? errorMsg;

  BaseActionResponse(super.cashifyAlert, super.trackUrl);

  static BaseActionResponse fromJson(Map<String, dynamic> json) => _$BaseActionResponseFromJson(json);

  static BaseActionResponse fromJsonWithInt(Map<String, dynamic> json) => _$BaseActionResponseWithIntFromJson(json);

  static BaseActionResponse _$BaseActionResponseWithIntFromJson(Map<String, dynamic> json) => BaseActionResponse(
        json['__ca'] == null ? null : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
        json['turl'] as String?,
      )
        ..refId = json['r_id'] as String?
        ..isSuccess = (json['s'] as int? ?? 0) == 1 ? true : false
        ..errorMsg = json['em'] as String?;

  @override
  Map<String, dynamic> toJson() => _$BaseActionResponseToJson(this);
}
