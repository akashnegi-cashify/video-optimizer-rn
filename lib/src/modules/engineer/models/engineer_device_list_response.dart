import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

import 'engineer_device_info.dart';

part 'engineer_device_list_response.g.dart';

@JsonSerializable()
class EngineerDeviceListResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<EngineerDeviceInfo>? deviceList;

  @JsonKey(name: "s", defaultValue: false)
  late bool isSuccess;

  EngineerDeviceListResponse(super.cashifyAlert, super.trackUrl);

  static EngineerDeviceListResponse fromJson(Map<String, dynamic> json) => _$EngineerDeviceListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EngineerDeviceListResponseToJson(this);
}
