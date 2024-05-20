import 'package:json_annotation/json_annotation.dart';

part 'imei_qrcode_response.g.dart';

@JsonSerializable()
class ImeiQrcodeResponse {
  @JsonKey(name: "imei1")
  String? imei1;

  @JsonKey(name: "imei2")
  String? imei2;

  @JsonKey(name: "awb")
  String? awbNumber;

  static ImeiQrcodeResponse fromJson(Map<String, dynamic> json) => _$ImeiQrcodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImeiQrcodeResponseToJson(this);
}
