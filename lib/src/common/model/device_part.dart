import 'package:json_annotation/json_annotation.dart';
part 'device_part.g.dart';


@JsonSerializable()
class DevicePart {

  @JsonKey(name: "sku")
  String? sku;
  @JsonKey(name: "pn")
  String? partName;
  @JsonKey(name: "pbr")
  String? partBarcode;
  @JsonKey(name: "dna")
  String? deviceName;
  @JsonKey(name: "dbr")
  String? deviceBarcode;
  @JsonKey(name: "pid")
  int? partId;
  @JsonKey(name:"pcl")
  String? partColor;
  @JsonKey(name: "isBulk")
  bool? isBulk;
  @JsonKey(name: "isUrgent")
  bool? isUrgent;
  @JsonKey(name:"prid")
  int? prId;


  static DevicePart fromJson(Map<String, dynamic> data) => _$DevicePartFromJson(data);

  Map<String, dynamic> toJson() => _$DevicePartToJson(this);

}
