import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'receive_device_detail_response.g.dart';

@JsonSerializable()
class ReceiveDeviceDetailResponse extends BaseResponse {
  @JsonKey(name: 'rt')
  int? receiveType;

  @JsonKey(name: 'acc')
  Map<String, String>? accessoriesMap;

  ReceiveDeviceDetailResponse(this.receiveType, this.accessoriesMap, super.cashifyAlert, super.trackUrl);

  static ReceiveDeviceDetailResponse fromJson(Map<String, dynamic> json) => _$ReceiveDeviceDetailResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReceiveDeviceDetailResponseToJson(this);
}
