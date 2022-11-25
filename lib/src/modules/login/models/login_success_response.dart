import 'package:json_annotation/json_annotation.dart';

part 'login_success_response.g.dart';

@JsonSerializable()
class LoginSuccessResponse {
  @JsonKey(name: "r_id")
  String? referenceId;
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "s")
  bool? status;

  LoginSuccessResponse({
    this.status,
    this.referenceId,
    this.token,
  });

  static LoginSuccessResponse fromJson(Map<String, dynamic> data) => _$LoginSuccessResponseFromJson(data);

  Map<String, dynamic> toJson() => _$LoginSuccessResponseToJson(this);
}
