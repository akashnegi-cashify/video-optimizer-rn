import 'package:json_annotation/json_annotation.dart';

part 'assigned_device_details.g.dart';

@JsonSerializable()
class AssignedDeviceDetails {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "dt")
  AssignDeviceDetailsData? detailsData;

  AssignedDeviceDetails({
    this.isSuccess,
    this.refId,
    this.detailsData,
  });

  static AssignedDeviceDetails fromJson(Map<String, dynamic> data) => _$AssignedDeviceDetailsFromJson(data);

  Map<String, dynamic> toJson() => _$AssignedDeviceDetailsToJson(this);
}

@JsonSerializable()
class AssignDeviceDetailsData {
  @JsonKey(name: "did")
  int? did;
  @JsonKey(name: "pt")
  String? productName;

  @JsonKey(name: "dbr")
  String? deviceBarcode;

  @JsonKey(name: "st")
  String? status;

  @JsonKey(name: "en")
  String? engineerName;

  @JsonKey(name: "rt")
  String? repairType;

  @JsonKey(name: "gr")
  String? grade;

  @JsonKey(name: "lc")
  String? lc;

  @JsonKey(name: "dr")
  String? deadRemark;

  @JsonKey(name: "rc")
  int? returnCount;

  @JsonKey(name: "ismu")
  bool? isScrewMediaUploaded;

  @JsonKey(name: "rr")
  String? returnReason;

  @JsonKey(name: "rrs")
  List<String>? repairReasonList;

  @JsonKey(name: "dimei")
  String? imei;

  @JsonKey(name: "sno")
  String? serialNumber;

  @JsonKey(name: "dc")
  String? color;

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
  });

  static AssignDeviceDetailsData fromJson(Map<String, dynamic> data) => _$AssignDeviceDetailsDataFromJson(data);

  Map<String, dynamic> toJson() => _$AssignDeviceDetailsDataToJson(this);
}
