import 'package:json_annotation/json_annotation.dart';

part 'body_shop_device_response.g.dart';

@JsonSerializable()
class BodyShopDevice {
  @JsonKey(name: "did")
  int? deviceId;

  @JsonKey(name: "dbr")
  String? deviceBarcode;

  @JsonKey(name: "mdl")
  String? model;

  @JsonKey(name: "sd")
  String? statusDescription;

  @JsonKey(name: "eng")
  String? engineer;

  @JsonKey(name: "img")
  String? image;

  BodyShopDevice({
    this.deviceId,
    this.deviceBarcode,
    this.model,
    this.statusDescription,
    this.engineer,
    this.image,
  });

  static BodyShopDevice fromJson(Map<String, dynamic> data) => _$BodyShopDeviceFromJson(data);

  Map<String, dynamic> toJson() => _$BodyShopDeviceToJson(this);
}
