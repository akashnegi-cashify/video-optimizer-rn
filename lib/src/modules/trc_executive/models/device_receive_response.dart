import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../common/model/base_action_response.dart';

part 'device_receive_response.g.dart';

@JsonSerializable()
class DeviceReceiveResponse extends BaseActionResponse {
  DeviceReceiveResponse(super.cashifyAlert, super.trackUrl);

  @JsonKey(name: "dt")
  DeviceReceiveData? data;

  static DeviceReceiveResponse fromJson(Map<String, dynamic> json) => _$DeviceReceiveResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeviceReceiveResponseToJson(this);
}

@JsonSerializable()
class DeviceReceiveData {
  @JsonKey(name: "pt")
  String? productTitle;

  @JsonKey(name: "dbr")
  String? deviceBarcode;

  @JsonKey(name: "st")
  String? status;

  @JsonKey(name: "rt")
  String? repairType;

  @JsonKey(name: "ro")
  String? repairOrder;

  @JsonKey(name: "isUrgent")
  bool? isUrgent;

  @JsonKey(name: "ele")
  String? elssEngineerName;

  DeviceReceiveData(
    this.productTitle,
    this.deviceBarcode,
    this.status,
    this.repairType,
    this.isUrgent,
    this.elssEngineerName,
    this.repairOrder,
  );

  static DeviceReceiveData fromJson(Map<String, dynamic> json) => _$DeviceReceiveDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceReceiveDataToJson(this);
}
