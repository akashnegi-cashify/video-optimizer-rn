import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_receive_response.g.dart';

@JsonSerializable()
class DeviceReceiveResponse extends BaseResponse {
  DeviceReceiveResponse(super.cashifyAlert, super.trackUrl);

  @JsonKey(name: "dt")
  DeviceReceiveData? data;

  @JsonKey(name: "r_id")
  String? refId;

  @JsonKey(name: "s", defaultValue: false)
  late bool isSuccess;

  @JsonKey(name: "em")
  String? errorMsg;

  static DeviceReceiveResponse fromJson(Map<String, dynamic> json) => _$DeviceReceiveResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeviceReceiveResponseToJson(this);

}

@JsonSerializable()
class DeviceReceiveData {
  @JsonKey(name: "deviceName")
  String? productTitle;

  @JsonKey(name: "deviceBarcode")
  String? deviceBarcode;

  @JsonKey(name: "deviceStatus")
  String? status;

  @JsonKey(name: "deviceRepairType")
  String? repairType;


  DeviceReceiveData(
    this.productTitle,
    this.deviceBarcode,
    this.status,
    this.repairType,
  );

  static DeviceReceiveData fromJson(Map<String, dynamic> json) => _$DeviceReceiveDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceReceiveDataToJson(this);
}
