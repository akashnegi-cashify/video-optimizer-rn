import 'package:json_annotation/json_annotation.dart';

part 'bin_out_verify_response.g.dart';

@JsonSerializable()
class BinOutVerifyResponse {
  @JsonKey(name: "s")
  int? success;

  bool isValid() {
    return success == 1;
  }

  @JsonKey(name: "ac")
  int? availableSpace;

  @JsonKey(name: "tc")
  int? totalSpace;

  @JsonKey(name: "message")
  String? message;

  BinOutVerifyResponse({
    this.success,
    this.availableSpace,
    this.totalSpace,
    this.message,
  });

  static BinOutVerifyResponse fromJson(Map<String, dynamic> data) =>
      _$BinOutVerifyResponseFromJson(data);

  Map<String, dynamic> toJson() => _$BinOutVerifyResponseToJson(this);
}
