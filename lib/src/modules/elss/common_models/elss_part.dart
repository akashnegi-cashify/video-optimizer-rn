import 'package:json_annotation/json_annotation.dart';

part 'elss_part.g.dart';

@JsonSerializable()
class ElssPart {
  @JsonKey(name: "sku")
  String? sku;
  @JsonKey(name: "pn")
  String? partName;
  @JsonKey(name: "ac")
  String? action;
  @JsonKey(name: "acc")
  int? actionConstant;
  @JsonKey(name: "isManualAdded")
  bool? isManualAdded;
  @JsonKey(name: "pc")
  int? partCount;
  @JsonKey(name: "pcl")
  String? partColour;
  @JsonKey(name: "isPnaSelected")
  bool? isPnaSelected;
  @JsonKey(name: "selectedPos")
  int? selectedPos;
  @JsonKey(name: "isVisibleForPna")
  bool? isVisibleForPna;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String>? partsImageList;
  @JsonKey(includeFromJson: false, includeToJson: false)
  int? elssPartId;
  @JsonKey(name: "qt")
  int? quantity;

  @JsonKey(name: "_v")
  int? version;

  ElssPart({
    this.version = 0,
    this.action = "Repairable",
    this.isManualAdded = false,
    this.isPnaSelected = false,
    this.isVisibleForPna = false,
    this.partColour,
    this.partCount,
    this.partName,
    this.selectedPos = -1,
    this.sku,
    this.elssPartId,
    this.partsImageList,
    this.actionConstant,
    this.quantity,
  });

  static ElssPart fromJson(Map<String, dynamic> data) => _$ElssPartFromJson(data);

  Map<String, dynamic> toJson() => _$ElssPartToJson(this);
}
