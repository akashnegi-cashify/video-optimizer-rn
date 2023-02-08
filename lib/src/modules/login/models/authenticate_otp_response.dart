import 'package:json_annotation/json_annotation.dart';

part 'authenticate_otp_response.g.dart';

@JsonSerializable()
class AuthenticateOTPResponse {
  @JsonKey(name: "access_token")
  String? accessToken;
  @JsonKey(name: "refresh_token")
  String? refreshToken;
  @JsonKey(name: "token_type")
  String? tokenType;
  @JsonKey(name: "isp", defaultValue: 0)
  int? isPublic;
  @JsonKey(name: "expires_in", defaultValue: 0)
  int? expiresIn;

  AuthenticateOTPResponse(
    this.tokenType,
    this.accessToken,
    this.expiresIn,
    this.isPublic,
    this.refreshToken,
  );
  static AuthenticateOTPResponse fromJson(Map<String, dynamic> data)=> _$AuthenticateOTPResponseFromJson(data);
  Map<String, dynamic> toJson()=> _$AuthenticateOTPResponseToJson(this);
}
