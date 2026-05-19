import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scan_device_response.g.dart';

@JsonSerializable()
class ScanDeviceResponse extends BaseResponse {
  @JsonKey(name: "dt")
  ScanDeviceData? scanDeviceData;

  ScanDeviceResponse(super.cashifyAlert, super.trackUrl);

  static ScanDeviceResponse fromJson(Map<String, dynamic> json) => _$ScanDeviceResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScanDeviceResponseToJson(this);
}

@JsonSerializable()
class ScanDeviceData {
  @JsonKey(name: "qrCode")
  String? deviceBarcode;

  @JsonKey(name: "status")
  int? status;

  @JsonKey(name: "remark")
  String? message;

  @JsonKey(name: "mediaMap")
  Map<String, String>? requiredImageList;

  @JsonKey(name: "currentStatus")
  String? currentStatus;

  @JsonKey(name: "productName")
  String? productName;

  @JsonKey(name: "imei1")
  String? imei1;

  @JsonKey(name: "imei2")
  String? imei2;

  @JsonKey(name: "moneyOutDate")
  int? moneyOutDate;

  @JsonKey(name: "storageLoc")
  String? storageLocation;

  static ScanDeviceData fromJson(Map<String, dynamic> json) => _$ScanDeviceDataFromJson(json);

  Map<String, dynamic> toJson() => _$ScanDeviceDataToJson(this);
}
