import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_engineer_part.g.dart';

@JsonSerializable()
class OrderEngineerPart extends EngineerPartInfo {
  @JsonKey(name: "qty")
  int? orderQuantity;

  @JsonKey(name: "_v")
  int? version;

  OrderEngineerPart(this.orderQuantity, {this.version = 0});

  static OrderEngineerPart fromJson(Map<String, dynamic> data) => _$OrderEngineerPartFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$OrderEngineerPartToJson(this);
}
