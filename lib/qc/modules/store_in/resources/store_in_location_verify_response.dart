import 'package:json_annotation/json_annotation.dart';

part 'store_in_location_verify_response.g.dart';

@JsonSerializable()
class StoreInLocationVerifyResponse {
  @JsonKey(name: "s")
  int? success;

  bool isValid() {
    return success == 1;
  }

  @JsonKey(name: "availableCapacity")
  int? availableSpace;

  @JsonKey(name: "totalCapacity")
  int? totalSpace;

  /// New fields for /store-in/validate-location
  @JsonKey(name: "verifyBarcodeStatus")
  int? verifyBarcodeStatus;

  /// Performance monitoring metric
  @JsonKey(name: "pm")
  double? performanceMonitoring;

  @JsonKey(name: "message")
  String? message;

  StoreInLocationVerifyResponse({
    this.success,
    this.availableSpace,
    this.totalSpace,
    this.verifyBarcodeStatus,
    this.performanceMonitoring,
    this.message,
  });

  static StoreInLocationVerifyResponse fromJson(Map<String, dynamic> data) =>
      _$StoreInLocationVerifyResponseFromJson(data);

  Map<String, dynamic> toJson() => _$StoreInLocationVerifyResponseToJson(this);
}
