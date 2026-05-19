import 'package:json_annotation/json_annotation.dart';

part 'brands_listing_models.g.dart';

@JsonSerializable()
class BrandsListingResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "dt")
  List<BrandsDataModel>? brandDataList;

  BrandsListingResponse({
    this.brandDataList,
    this.refId,
  });

  static BrandsListingResponse fromJson(Map<String, dynamic> data) => _$BrandsListingResponseFromJson(data);

  Map<String, dynamic> toJson() => _$BrandsListingResponseToJson(this);
}

@JsonSerializable()
class BrandsDataModel {
  @JsonKey(name: "key")
  String? brandId;
  @JsonKey(name: "value")
  String? brandName;

  BrandsDataModel({
    this.brandId,
    this.brandName,
  });

  static BrandsDataModel fromJson(Map<String, dynamic> data) => _$BrandsDataModelFromJson(data);

  Map<String, dynamic> toJson() => _$BrandsDataModelToJson(this);
}
