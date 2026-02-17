import 'package:json_annotation/json_annotation.dart';

part 'login_success_response.g.dart';

@JsonSerializable()
class LoginSuccessResponse {
  @JsonKey(name: "r_id")
  String? referenceId;
  @JsonKey(name: "dt")
  LoginSuccessData? data;

  LoginSuccessResponse({
    this.referenceId,
    this.data,
  });

  static LoginSuccessResponse fromJson(Map<String, dynamic> data) => _$LoginSuccessResponseFromJson(data);

  Map<String, dynamic> toJson() => _$LoginSuccessResponseToJson(this);
}

@JsonSerializable()
class LoginSuccessData {
  @JsonKey(name: "token")
  String? token;

  LoginSuccessData(this.token);

  static LoginSuccessData fromJson(Map<String, dynamic> data) => _$LoginSuccessDataFromJson(data);

  Map<String, dynamic> toJson() => _$LoginSuccessDataToJson(this);
}
