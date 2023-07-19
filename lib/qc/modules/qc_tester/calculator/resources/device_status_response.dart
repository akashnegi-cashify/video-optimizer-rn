import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_status_response.g.dart';

@JsonSerializable()
class DeviceStatusResponse extends BaseResponse {

  @JsonKey(name: "trcStatus")
  String? trcStatus;

  @JsonKey(name: "salesChannels")
  List<String>? salesChannels;

  DeviceStatusResponse(this.trcStatus, this.salesChannels, super.cashifyAlert, super.trackUrl);

  static DeviceStatusResponse fromJson(Map<String, dynamic> json) => _$DeviceStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceStatusResponseToJson(this);
}