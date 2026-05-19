import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../models/engineer_action_response.dart';
import '../../../models/engineer_device_info.dart';

part 'change_device_status_response.g.dart';

@JsonSerializable()
class ChangeDeviceStatusResponse extends EngineerActionResponse {
  ChangeDeviceStatusResponse(super.cashifyAlert, super.trackUrl);

  static ChangeDeviceStatusResponse fromJson(Map<String, dynamic> json) => _$ChangeDeviceStatusResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChangeDeviceStatusResponseToJson(this);
}
