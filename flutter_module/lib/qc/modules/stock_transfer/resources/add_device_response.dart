import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_device_response.g.dart';

@JsonSerializable()
class AddDeviceResponse extends BaseResponse {
  @JsonKey(name: 'rs')
  bool? isReset;

  AddDeviceResponse(this.isReset, super.cashifyAlert, super.trackUrl);

  static AddDeviceResponse fromJson(Map<String, dynamic> json) => _$AddDeviceResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AddDeviceResponseToJson(this);
}
