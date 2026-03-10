import 'package:json_annotation/json_annotation.dart';

part 'elss_part.g.dart';

@JsonSerializable()
class ElssPart {
  @JsonKey(name: "sku")
  String? sku;
  @JsonKey(name: "partName")
  String? partName;
  @JsonKey(name: "action")
  String? action;
  @JsonKey(name: "actionCode")
  int? actionConstant;
  @JsonKey(name: "isManualAdded")
  bool? isManualAdded;
  @JsonKey(name: "partCount")
  int? partCount;
  @JsonKey(name: "partColor")
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
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "_v")
  int? version;
  @JsonKey(name: "categoryCode")
  String? categoryCode;

  @JsonKey(name: "price")
  double? price;

  @JsonKey(name: "partVariantName")
  String? partVariantName;

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
    this.categoryCode,
    this.price,
    this.partVariantName,
  });

  static ElssPart fromJson(Map<String, dynamic> data) => _$ElssPartFromJson(data);

  Map<String, dynamic> toJson() => _$ElssPartToJson(this);
}
