import 'package:json_annotation/json_annotation.dart';

part 'pending_device_list_response.g.dart';

@JsonSerializable()
class PendingDeviceListResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "dt")
  PendingDeviceData? data;

  PendingDeviceListResponse({
    this.isSuccess,
    this.refId,
    this.data,
  });

  static PendingDeviceListResponse fromJson(Map<String, dynamic> data) => _$PendingDeviceListResponseFromJson(data);

  Map<String, dynamic> toJson() => _$PendingDeviceListResponseToJson(this);
}

@JsonSerializable()
class PendingDeviceData {
  @JsonKey(name: "tp")
  int? totalPage;
  @JsonKey(name: "tr")
  int? totalRecords;
  @JsonKey(name: "dl")
  List<PendingDeviceDetailData>? dataList;

  PendingDeviceData({
    this.totalPage,
    this.totalRecords,
    this.dataList,
  });

  static PendingDeviceData fromJson(Map<String, dynamic> data) => _$PendingDeviceDataFromJson(data);

  Map<String, dynamic> toJson() => _$PendingDeviceDataToJson(this);
}

@JsonSerializable()
class PendingDeviceDetailData {
  @JsonKey(name: "did")
  int? did;

  @JsonKey(name: "pt")
  String? pt;

  @JsonKey(name: "dbr")
  String? deviceBarcode;

  @JsonKey(name: "tbr")
  String? tbr;

  @JsonKey(name: 'pc')
  int? partCount;

  @JsonKey(name: "tpc")
  int? totalPartCount;

  @JsonKey(name: "en")
  String? engineerName;

  @JsonKey(name: "lc")
  String? lc;

  @JsonKey(name: "asAt")
  int? assignedAt;

  @JsonKey(name: "isUrgent")
  bool? isUrgent;

  @JsonKey(name: "rt")
  String? repairType;

  @JsonKey(name: "gr")
  String? grade;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isAssignedToRider;

  PendingDeviceDetailData({
    this.isUrgent,
    this.repairType,
    this.partCount,
    this.grade,
    this.deviceBarcode,
    this.assignedAt,
    this.did,
    this.engineerName,
    this.lc,
    this.pt,
    this.tbr,
    this.totalPartCount,
    this.isAssignedToRider = false,
  });

  static PendingDeviceDetailData fromJson(Map<String, dynamic> data) => _$PendingDeviceDetailDataFromJson(data);

  Map<String, dynamic> toJson() => _$PendingDeviceDetailDataToJson(this);
}
