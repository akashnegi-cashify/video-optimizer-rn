import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'receive_device_response.g.dart';

@JsonSerializable()
class ReceiveDeviceResponse extends BaseResponse {
  @JsonKey(name: "isSuccess", defaultValue: false)
  late bool isSuccess;

  @JsonKey(name: "successMsg")
  String? successMsg;

  @JsonKey(name: "responseData")
  ReceiveDeviceData? responseData;

  ReceiveDeviceResponse(super.cashifyAlert, super.trackUrl);

  static ReceiveDeviceResponse fromJson(Map<String, dynamic> json) => _$ReceiveDeviceResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReceiveDeviceResponseToJson(this);
}

@JsonSerializable()
class ReceiveDeviceData {
  @JsonKey(name: "did")
  int? deviceId;

  @JsonKey(name: "dbr")
  String? deviceBarcode;

  @JsonKey(name: "mdl")
  String? model;

  @JsonKey(name: "sc")
  int? statusCode;

  @JsonKey(name: "sd")
  String? statusDescription;

  @JsonKey(name: "eng")
  String? engineer;

  @JsonKey(name: "img")
  String? image;

  ReceiveDeviceData();

  static ReceiveDeviceData fromJson(Map<String, dynamic> json) => _$ReceiveDeviceDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiveDeviceDataToJson(this);
}
