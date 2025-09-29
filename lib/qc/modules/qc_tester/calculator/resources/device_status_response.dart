import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_status_response.g.dart';

@JsonSerializable()
class DeviceStatusResponse extends BaseResponse {

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "salesChannels")
  List<String>? salesChannels;

  @JsonKey(name: "stockAge")
  int? stockAge;

  @JsonKey(name: "isCaptureQcImages")
  bool? isCaptureQcImages;

  DeviceStatusResponse(this.status, this.salesChannels, this.stockAge, this.isCaptureQcImages, super.cashifyAlert, super.trackUrl);

  static DeviceStatusResponse fromJson(Map<String, dynamic> json) => _$DeviceStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceStatusResponseToJson(this);
}