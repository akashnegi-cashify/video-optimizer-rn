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
  @JsonKey(name: "productTitle")
  String? productTitle;

  @JsonKey(name: "deviceBarcode")
  String? deviceBarcode;

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "repairType")
  String? repairType;

  @JsonKey(name: "repairOrderNo")
  String? repairOrder;

  @JsonKey(name: "isUrgent")
  bool? isUrgent;

  @JsonKey(name: "ele")
  String? elssEngineerName;

  @JsonKey(name: "rubbingStatus")
  int? rubbingOrGlassChangeStatus;

  DeviceReceiveData(
      this.productTitle,
      this.deviceBarcode,
      this.status,
      this.repairType,
      this.isUrgent,
      this.elssEngineerName,
      this.repairOrder,
      this.rubbingOrGlassChangeStatus,
      );

  static DeviceReceiveData fromJson(Map<String, dynamic> json) => _$DeviceReceiveDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceReceiveDataToJson(this);
}