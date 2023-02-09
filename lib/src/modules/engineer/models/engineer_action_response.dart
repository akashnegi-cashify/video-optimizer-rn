import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

import 'engineer_device_info.dart';

part 'engineer_action_response.g.dart';

@JsonSerializable()
class EngineerActionResponse extends BaseResponse {
  @JsonKey(name: "s")
  late bool isSuccess;

  @JsonKey(name: "em")
  String? errorMsg;

  @JsonKey(name: "dt")
  EngineerDeviceInfo? deviceInfo;

  EngineerActionResponse(super.cashifyAlert, super.trackUrl);

  static EngineerActionResponse fromJson(Map<String, dynamic> json) => _$EngineerActionResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EngineerActionResponseToJson(this);
}
