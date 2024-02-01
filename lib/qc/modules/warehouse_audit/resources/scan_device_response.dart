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
  @JsonKey(name: "qc")
  String? deviceBarcode;

  @JsonKey(name: "s")
  int? status;

  @JsonKey(name: "rm")
  String? message;

  @JsonKey(name: "mm")
  Map<String, String>? requiredImageList;

  static ScanDeviceData fromJson(Map<String, dynamic> json) => _$ScanDeviceDataFromJson(json);

  Map<String, dynamic> toJson() => _$ScanDeviceDataToJson(this);
}
