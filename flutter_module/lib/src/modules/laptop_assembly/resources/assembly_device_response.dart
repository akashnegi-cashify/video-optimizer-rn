import 'package:json_annotation/json_annotation.dart';

part 'assembly_device_response.g.dart';

@JsonSerializable()
class AssemblyDevice {
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

  AssemblyDevice({
    this.deviceId,
    this.deviceBarcode,
    this.model,
    this.statusCode,
    this.statusDescription,
    this.engineer,
    this.image,
  });

  static AssemblyDevice fromJson(Map<String, dynamic> data) => _$AssemblyDeviceFromJson(data);

  Map<String, dynamic> toJson() => _$AssemblyDeviceToJson(this);
}
