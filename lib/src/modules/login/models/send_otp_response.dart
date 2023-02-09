import 'package:json_annotation/json_annotation.dart';
part 'send_otp_response.g.dart';

@JsonSerializable()
class SendOTPResponse {
  @JsonKey(name: "rid")
  String? requestId;

  SendOTPResponse({this.requestId});

  static SendOTPResponse fromJson(Map<String, dynamic> data) => _$SendOTPResponseFromJson(data);

  Map<String, dynamic> toJson() => _$SendOTPResponseToJson(this);
}
