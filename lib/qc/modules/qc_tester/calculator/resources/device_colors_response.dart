import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_colors_response.g.dart';

@JsonSerializable()
class DeviceColorResponse extends BaseResponse {

  @JsonKey(name: "dt")
  List<String>? deviceColorList;

  @JsonKey(name: "scl")
  List<String>? strapColorList;

  DeviceColorResponse(this.deviceColorList, this.strapColorList, super.cashifyAlert, super.trackUrl);

  static DeviceColorResponse fromJson(Map<String, dynamic> json) => _$DeviceColorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceColorResponseToJson(this);
}