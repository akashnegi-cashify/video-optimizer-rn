import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/order_engineer_part.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_part_response.g.dart';

@JsonSerializable()
class OrderPartResponse extends BaseResponse {
  @JsonKey(name: "r_id")
  late String refId;
  @JsonKey(name: "s", defaultValue: false)
  late bool isSuccess;
  @JsonKey(name: "em")
  String? errorMsg;
  @JsonKey(name: "dt")
  List<OrderEngineerPart>? partDataList;

  OrderPartResponse(super.cashifyAlert, super.trackUrl);

  static OrderPartResponse fromJson(Map<String, dynamic> data) => _$OrderPartResponseFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$OrderPartResponseToJson(this);
}
