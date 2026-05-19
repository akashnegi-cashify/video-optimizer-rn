import 'package:json_annotation/json_annotation.dart';

part 'store_in_device_request.g.dart';

@JsonSerializable()
class StoreInDeviceRequest {
  @JsonKey(name: "stockBarcode")
  String? stockBarcode;

  @JsonKey(name: "locBarcode")
  String? locBarcode;

  StoreInDeviceRequest({
    this.stockBarcode,
    this.locBarcode,
  });

  static StoreInDeviceRequest fromJson(Map<String, dynamic> data) => _$StoreInDeviceRequestFromJson(data);

  Map<String, dynamic> toJson() => _$StoreInDeviceRequestToJson(this);

}
