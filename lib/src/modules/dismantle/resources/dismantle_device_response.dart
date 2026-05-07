import 'package:json_annotation/json_annotation.dart';

part 'dismantle_device_response.g.dart';

@JsonSerializable()
class DismantleDevice {
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

  @JsonKey(name: "pts")
  List<DismantlePart>? parts;

  DismantleDevice({
    this.deviceId,
    this.deviceBarcode,
    this.model,
    this.statusDescription,
    this.engineer,
    this.parts,
  });

  static DismantleDevice fromJson(Map<String, dynamic> data) => _$DismantleDeviceFromJson(data);

  Map<String, dynamic> toJson() => _$DismantleDeviceToJson(this);
}

@JsonSerializable()
class DismantlePart {
  @JsonKey(name: "pid")
  int? partId;

  @JsonKey(name: "pn")
  String? partName;

  @JsonKey(name: "bc")
  String? barcode;

  DismantlePart({this.partId, this.partName, this.barcode});

  static DismantlePart fromJson(Map<String, dynamic> data) => _$DismantlePartFromJson(data);

  Map<String, dynamic> toJson() => _$DismantlePartToJson(this);
}
