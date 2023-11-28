import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_engineer_part.g.dart';

@JsonSerializable()
class OrderEngineerPart extends EngineerPartInfo {
  @JsonKey(name: "qty")
  int? orderQuantity;

  @JsonKey(name: "_v")
  int? version;

  @JsonKey(name: "action")
  int? partType;

  @JsonKey(includeToJson: false, includeFromJson: false)
  DropDownItem? _selectedPartType;

  OrderEngineerPart(this.orderQuantity, {this.version = 0});

  @JsonKey(includeToJson: false, includeFromJson: false)
  DropDownItem? get selectedPartType => _selectedPartType;

  set selectedPartType(DropDownItem? value) {
    _selectedPartType = value;
    partType = int.parse(value!.id!);
    orderQuantity = 1;
  }

  static OrderEngineerPart fromJson(Map<String, dynamic> data) => _$OrderEngineerPartFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$OrderEngineerPartToJson(this);
}
