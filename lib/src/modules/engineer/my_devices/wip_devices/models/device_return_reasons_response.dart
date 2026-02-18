import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';
part 'device_return_reasons_response.g.dart';

@JsonSerializable()
class DeviceReturnReasonsResponse extends BaseResponse {
  @JsonKey(name: "r_id")
  late String rId;

  @JsonKey(name: "em")
  String? errorMsg;

  @JsonKey(name: "dt")
  Map<String, String>? reasons;

  DeviceReturnReasonsResponse(super.cashifyAlert, super.trackUrl);

  static DeviceReturnReasonsResponse fromJson(Map<String, dynamic> json) => _$DeviceReturnReasonsResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeviceReturnReasonsResponseToJson(this);
}
