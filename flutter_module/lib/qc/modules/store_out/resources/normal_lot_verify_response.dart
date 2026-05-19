import 'package:json_annotation/json_annotation.dart';

part 'normal_lot_verify_response.g.dart';

@JsonSerializable()
class NormalLotVerifyResponse {
  @JsonKey(name: "message")
  String? message;

  NormalLotVerifyResponse({
    this.message,
  });

  static NormalLotVerifyResponse fromJson(Map<String, dynamic> data) => _$NormalLotVerifyResponseFromJson(data);

  Map<String, dynamic> toJson() => _$NormalLotVerifyResponseToJson(this);

  bool isValid() {
    return true;
  }
}
