import 'package:json_annotation/json_annotation.dart';

part 'part_device_list.g.dart';

@JsonSerializable()
class PartDeviceListResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "dt")
  List<PartItemDataResponse>? partDataList;

  PartDeviceListResponse(
    this.refId,
    this.partDataList,
  );

  static PartDeviceListResponse fromJson(Map<String, dynamic> data) => _$PartDeviceListResponseFromJson(data);

  Map<String, dynamic> toJson() => _$PartDeviceListResponseToJson(this);
}

@JsonSerializable()
class PartItemDataResponse {
  @JsonKey(name: "sku")
  String? sku;

  @JsonKey(name: "pn")
  String? productName;

  @JsonKey(name: "pvn")
  String? productVariantName;

  @JsonKey(name: "pcl")
  String? productColour;

  @JsonKey(name: "qty")
  int? partQuantity;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isCardSelected;

  @JsonKey(includeFromJson: false, includeToJson: false)
  int? partId;

  @JsonKey(name: "emsg")
  String? errorMessage;

  @JsonKey(name: "cc")
  String? categoryCode;

  @JsonKey(name: "price")
  double? price;

  PartItemDataResponse(
    this.sku,
    this.productColour,
    this.productName, {
    this.isCardSelected = false,
    this.partId,
    this.partQuantity,
    this.errorMessage,
    this.categoryCode,
    this.productVariantName,
    this.price,
  });

  static PartItemDataResponse fromJson(Map<String, dynamic> data) => _$PartItemDataResponseFromJson(data);

  Map<String, dynamic> toJson() => _$PartItemDataResponseToJson(this);
}
