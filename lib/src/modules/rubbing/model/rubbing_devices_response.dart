import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_list_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rubbing_devices_response.g.dart';

@JsonSerializable()
class RubbingDevicesResponse extends BaseResponse {

  @JsonKey(name: "r_id")
  late String rId;
  @JsonKey(name: "dt")
  RubbingListData? dt;
  @JsonKey(name: "s", defaultValue: false)
  late bool s;

  RubbingDevicesResponse(super.cashifyAlert, super.trackUrl);

  static RubbingDevicesResponse fromJson(Map<String, dynamic> data) => _$RubbingDevicesResponseFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$RubbingDevicesResponseToJson(this);
}
