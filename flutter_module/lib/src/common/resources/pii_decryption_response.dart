import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pii_decryption_response.g.dart';

@JsonSerializable()
class PiiDecryptionResponse extends BaseResponse {

  @JsonKey(name: "data")
  String? data;

  @JsonKey(name: "piiEnum")
  String? piiEnum;

  @JsonKey(name: "displayData")
  String? displayData;

  PiiDecryptionResponse(super.cashifyAlert, super.trackUrl);

  static PiiDecryptionResponse fromJson(Map<String, dynamic> json) => _$PiiDecryptionResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PiiDecryptionResponseToJson(this);
}