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

  @JsonKey(includeToJson: false, includeFromJson: false)
  DropDownItem? get selectedPartType => _selectedPartType;

  @JsonKey(name: "rrid")
  int? reasonId;

  @JsonKey(name: "imgs")
  List<String>? imageList;

  OrderEngineerPart(this.orderQuantity, {this.version = 0});

  set selectedPartType(DropDownItem? value) {
    _selectedPartType = value;
    if (value == null) {
     partType = null;
    } else {
      partType = int.parse(value.id!);
      orderQuantity = 1;
    }
  }

  static OrderEngineerPart fromJson(Map<String, dynamic> data) => _$OrderEngineerPartFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$OrderEngineerPartToJson(this);
}
