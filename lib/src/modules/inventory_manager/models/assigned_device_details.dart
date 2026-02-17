import 'package:json_annotation/json_annotation.dart';

part 'assigned_device_details.g.dart';

@JsonSerializable()
class AssignedDeviceDetails {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "dt")
  AssignDeviceDetailsData? detailsData;

  AssignedDeviceDetails({
    this.refId,
    this.detailsData,
  });

  static AssignedDeviceDetails fromJson(Map<String, dynamic> data) => _$AssignedDeviceDetailsFromJson(data);

  Map<String, dynamic> toJson() => _$AssignedDeviceDetailsToJson(this);
}

@JsonSerializable()
class AssignDeviceDetailsData {
  @JsonKey(name: "deviceId")
  int? did;

  @JsonKey(name: "productTitle")
  String? productName;

  @JsonKey(name: "deviceBarcode")
  String? deviceBarcode;

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "engineerName")
  String? engineerName;

  @JsonKey(name: "repairType")
  String? repairType;

  @JsonKey(name: "grade")
  String? grade;

  @JsonKey(name: "location")
  String? lc;

  @JsonKey(name: "deadRemark")
  String? deadRemark;

  @JsonKey(name: "returnCount")
  int? returnCount;

  @JsonKey(name: "skewImageTaken")
  bool? isScrewMediaUploaded;

  @JsonKey(name: "returnReason")
  String? returnReason;

  @JsonKey(name: "repairReasons")
  List<String>? repairReasonList;

  @JsonKey(name: "deviceImei")
  String? imei;

  @JsonKey(name: "serailNo")
  String? serialNumber;

  @JsonKey(name: "deviceColor")
  String? color;

  @JsonKey(name: "isUrgent")
  bool? isUrgent;

  AssignDeviceDetailsData({
    this.did,
    this.lc,
    this.engineerName,
    this.deviceBarcode,
    this.status,
    this.grade,
    this.repairType,
    this.productName,
    this.deadRemark,
    this.returnCount,
    this.isScrewMediaUploaded,
    this.imei,
    this.repairReasonList,
    this.returnReason,
    this.color,
    this.serialNumber,
    this.isUrgent,
  });

  static AssignDeviceDetailsData fromJson(Map<String, dynamic> data) => _$AssignDeviceDetailsDataFromJson(data);

  Map<String, dynamic> toJson() => _$AssignDeviceDetailsDataToJson(this);
}
