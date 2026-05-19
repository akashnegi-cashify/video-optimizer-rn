import 'package:json_annotation/json_annotation.dart';

part 'paint_shop_device_response.g.dart';

@JsonSerializable()
class PaintShopDevice {
  @JsonKey(name: "did")
  int? deviceId;

  @JsonKey(name: "dbr")
  String? deviceBarcode;

  @JsonKey(name: "mdl")
  String? model;

  @JsonKey(name: "sc")
  int? statusCode;

  @JsonKey(name: "sd")
  String? statusDescription;

  @JsonKey(name: "eng")
  String? engineer;

  @JsonKey(name: "img")
  String? image;

  PaintShopDevice({
    this.deviceId,
    this.deviceBarcode,
    this.model,
    this.statusCode,
    this.statusDescription,
    this.engineer,
    this.image,
  });

  static PaintShopDevice fromJson(Map<String, dynamic> data) => _$PaintShopDeviceFromJson(data);

  Map<String, dynamic> toJson() => _$PaintShopDeviceToJson(this);
}
