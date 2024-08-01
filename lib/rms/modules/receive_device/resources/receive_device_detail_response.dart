import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'receive_device_detail_response.g.dart';

@JsonSerializable()
class ReceiveDeviceDetailResponse extends BaseResponse {
  @JsonKey(name: 'rt')
  int? receiveType;

  ReceiveDeviceDetailResponse(this.receiveType, super.cashifyAlert, super.trackUrl);

  static ReceiveDeviceDetailResponse fromJson(Map<String, dynamic> json) => _$ReceiveDeviceDetailResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReceiveDeviceDetailResponseToJson(this);
}
