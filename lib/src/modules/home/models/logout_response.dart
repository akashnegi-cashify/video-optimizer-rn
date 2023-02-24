import 'package:json_annotation/json_annotation.dart';

part 'logout_response.g.dart';

@JsonSerializable()
class LogoutResponse {
  @JsonKey(name: "r_id")
  String? referenceId;
  @JsonKey(name: "s")
  int? status;
  @JsonKey(name: "msg")
  String? successMessage;

  LogoutResponse(
    this.status,
    this.referenceId,
    this.successMessage,
  );

  static LogoutResponse fromJson(Map<String, dynamic> data) => _$LogoutResponseFromJson(data);

  Map<String, dynamic> toJson() => _$LogoutResponseToJson(this);
}
