import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rubbing_device_receive_response.g.dart';

@JsonSerializable()
class RubbingDeviceReceiveResponse extends BaseResponse {
  @JsonKey(name: "s", defaultValue: false)
  late bool isSuccess;

  @JsonKey(name: "sm")
  String? successMsg;

  @JsonKey(name: "em")
  String? errorMsg;

  RubbingDeviceReceiveResponse(this.isSuccess, this.successMsg, this.errorMsg, super.cashifyAlert, super.trackUrl);

  static RubbingDeviceReceiveResponse fromJson(Map<String, dynamic> data) =>
      _$RubbingDeviceReceiveResponseFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$RubbingDeviceReceiveResponseToJson(this);

}
