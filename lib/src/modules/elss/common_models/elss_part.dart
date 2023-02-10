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
  @JsonKey(ignore: true)
  List<String>? partsImageList;
  @JsonKey(ignore: true)
  int? elssPartId;
  @JsonKey(ignore: true)
  bool? isManuallyAdded;
  @JsonKey(name: "_v")
  int? version;

  @JsonKey(name: "ac")
  ElssPart({
    this.version = 0,
    this.action,
    this.isManualAdded,
    this.isPnaSelected = false,
    this.isVisibleForPna = false,
    this.partColour,
    this.partCount,
    this.partName,
    this.selectedPos = -1,
    this.sku,
    this.elssPartId,
    this.isManuallyAdded = false,
    this.partsImageList,
    this.actionConstant,
  });

  static ElssPart fromJson(Map<String, dynamic> data) => _$ElssPartFromJson(data);

  Map<String, dynamic> toJson() => _$ElssPartToJson(this);
}
