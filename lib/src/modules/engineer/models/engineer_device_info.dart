import 'package:json_annotation/json_annotation.dart';

part 'engineer_device_info.g.dart';

@JsonSerializable()
class EngineerDeviceInfo {
  @JsonKey(name: "did")
  late int deviceId;

  @JsonKey(name: "rr")
  String? returnReason;

  @JsonKey(name: "pt")
  String? productTitle;

  @JsonKey(name: "dbr")
  String? deviceBarcode;

  @JsonKey(name: "st")
  String? status;

  @JsonKey(name: "rt")
  String? repairType;

  @JsonKey(name: "gr")
  String? grade;

  @JsonKey(name: "dimei")
  String? imei;

  @JsonKey(name: "dc")
  String? color;

  @JsonKey(name: "rc")
  int? returnCount;

  @JsonKey(name: "rrs")
  List<String>? repairReasonList;

  @JsonKey(includeToJson: false, includeFromJson: false)
  String? deadRemark;

  static EngineerDeviceInfo fromJson(Map<String, dynamic> json) => _$EngineerDeviceInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EngineerDeviceInfoToJson(this);
}
