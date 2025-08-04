import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_device_testing_response.g.dart';

@JsonSerializable()
class CheckDeviceTestingResponse extends BaseResponse {
  @JsonKey(name: "dt")
  Map<String, bool> response;

  CheckDeviceTestingResponse(this.response, super.cashifyAlert, super.trackUrl);

  bool get isTestingPass => response.containsKey("ip") ? (response["ip"] ?? false) : false;

  static CheckDeviceTestingResponse fromJson(Map<String, dynamic> json) => _$CheckDeviceTestingResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CheckDeviceTestingResponseToJson(this);
}
