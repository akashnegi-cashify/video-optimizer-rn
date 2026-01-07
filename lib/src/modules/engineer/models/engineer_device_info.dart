import 'package:json_annotation/json_annotation.dart';

part 'engineer_device_info.g.dart';

@JsonSerializable()
class EngineerDeviceInfo {
  @JsonKey(name: "deviceId")
  late int deviceId;

  @JsonKey(name: "returnReason")
  String? returnReason;

  @JsonKey(name: "productTitle")
  String? productTitle;

  @JsonKey(name: "deviceBarcode")
  String? deviceBarcode;

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "repairType")
  String? repairType;

  @JsonKey(name: "grade")
  String? grade;

  @JsonKey(name: "deviceImei")
  String? imei;

  @JsonKey(name: "deviceColor")
  String? color;

  @JsonKey(name: "isUrgent")
  bool? isUrgent;

  @JsonKey(name: "skewImageTaken")
  bool? skewImageTaken;

  @JsonKey(includeToJson: false, includeFromJson: false)
  int? returnCount;

  @JsonKey(includeToJson: false, includeFromJson: false)
  List<String>? repairReasonList;

  @JsonKey(includeToJson: false, includeFromJson: false)
  String? deadRemark;

  static EngineerDeviceInfo fromJson(Map<String, dynamic> json) => _$EngineerDeviceInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EngineerDeviceInfoToJson(this);
}
