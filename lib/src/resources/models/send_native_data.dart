import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_native_data.g.dart';

@JsonSerializable()
class NativeData {
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "authData")
  OAuthResponse? authResponse;

  NativeData({this.token, this.authResponse});

  static NativeData fromJson(Map<String, dynamic> data) => _$NativeDataFromJson(data);

  Map<String, dynamic> toJson() => _$NativeDataToJson(this);
}
