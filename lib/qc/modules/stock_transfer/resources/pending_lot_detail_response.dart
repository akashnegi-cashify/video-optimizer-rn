import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pending_lot_detail_response.g.dart';

@JsonSerializable()
class PendingLotDetailResponse extends BaseResponse {
  @JsonKey(name: "lid")
  int? lotId;

  @JsonKey(name: "lotName")
  String? lotName;

  @JsonKey(name: "deviceCount")
  int? deviceCount;

  @JsonKey(name: "destination")
  String? destinationFacility;

  @JsonKey(name: "rm")
  String? rmName;

  @JsonKey(name: "statusCode")
  int? statusCode;

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "cb")
  int? createdByName;

  @JsonKey(name: "cd")
  String? createdDate;

  @JsonKey(name: "deviceDetailsList")
  List<PendingLotDeviceListData>? deviceList;

  PendingLotDetailResponse(
    this.lotId,
    this.lotName,
    this.deviceCount,
    this.destinationFacility,
    this.rmName,
    this.statusCode,
    this.status,
    this.createdByName,
    this.createdDate,
    this.deviceList,
    super.cashifyAlert,
    super.trackUrl,
  );

  static PendingLotDetailResponse fromJson(Map<String, dynamic> json) => _$PendingLotDetailResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PendingLotDetailResponseToJson(this);
}

@JsonSerializable()
class PendingLotDeviceListData {
  @JsonKey(name: "qr")
  String? qrCode;

  @JsonKey(name: "mo")
  String? model;

  @JsonKey(name: "br")
  String? brand;

  @JsonKey(name: "im")
  String? imeiNo;

  @JsonKey(name: "ab")
  String? createdBy;

  @JsonKey(name: "src")
  String? source;

  @JsonKey(name: "aa")
  int? createdDate;

  PendingLotDeviceListData(
      this.qrCode, this.model, this.brand, this.imeiNo, this.createdBy, this.source, this.createdDate);

  static PendingLotDeviceListData fromJson(Map<String, dynamic> json) => _$PendingLotDeviceListDataFromJson(json);

  Map<String, dynamic> toJson() => _$PendingLotDeviceListDataToJson(this);
}
