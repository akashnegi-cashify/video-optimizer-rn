import 'package:json_annotation/json_annotation.dart';

part 'brands_all_products.g.dart';

@JsonSerializable()
class BrandsAllProductResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "dt")
  List<BrandsAllProductDataList>? listOfAllProducts;

  BrandsAllProductResponse({
    this.isSuccess,
    this.listOfAllProducts,
    this.refId,
  });

  static BrandsAllProductResponse fromJson(Map<String, dynamic> data) => _$BrandsAllProductResponseFromJson(data);

  Map<String, dynamic> toJson() => _$BrandsAllProductResponseToJson(this);
}

@JsonSerializable()
class BrandsAllProductDataList {
  @JsonKey(name: "key")
  String? pid;
  @JsonKey(name: "value")
  String? productName;

  BrandsAllProductDataList({
    this.productName,
    this.pid,
  });

  static BrandsAllProductDataList fromJson(Map<String, dynamic> data) => _$BrandsAllProductDataListFromJson(data);

  Map<String, dynamic> toJson() => _$BrandsAllProductDataListToJson(this);
}
