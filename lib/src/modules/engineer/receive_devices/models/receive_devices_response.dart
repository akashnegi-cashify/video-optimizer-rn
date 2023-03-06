import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'device_info.dart';
part 'receive_devices_response.g.dart';

@JsonSerializable()
class ReceiveDevicesResponse extends BaseActionResponse {
  @JsonKey(name: "dt")
  DeviceInfo? deviceInfo;

  ReceiveDevicesResponse(super.cashifyAlert, super.trackUrl);

  static ReceiveDevicesResponse fromJson(Map<String, dynamic> data) => _$ReceiveDevicesResponseFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$ReceiveDevicesResponseToJson(this);
}
