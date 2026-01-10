import 'package:json_annotation/json_annotation.dart';

part 'store_in_location_verify_response.g.dart';

@JsonSerializable()
class StoreInLocationVerifyResponse {
  @JsonKey(name: "availableCapacity")
  int? availableSpace;

  @JsonKey(name: "totalCapacity")
  int? totalSpace;

  @JsonKey(name: "verifyBarcodeStatus")
  int? verifyBarcodeStatus;

  @JsonKey(name: "message")
  String? message;

  StoreInLocationVerifyResponse({
    this.availableSpace,
    this.totalSpace,
    this.verifyBarcodeStatus,
    this.message,
  });

  static StoreInLocationVerifyResponse fromJson(Map<String, dynamic> data) =>
      _$StoreInLocationVerifyResponseFromJson(data);

  Map<String, dynamic> toJson() => _$StoreInLocationVerifyResponseToJson(this);
}

@JsonSerializable()
class VerifyBarcode {
  @JsonKey(name: "qrCode")
  String? qrCode;

  VerifyBarcode({this.qrCode});

  static VerifyBarcode fromJson(Map<String, dynamic> json) => _$VerifyBarcodeFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyBarcodeToJson(this);
}
