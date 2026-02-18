import 'package:json_annotation/json_annotation.dart';

part 'products_colour_response.g.dart';

@JsonSerializable()
class ProductsColorResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "color")
  List<String>? listOfColours;

  ProductsColorResponse({
    this.listOfColours,
    this.refId,
  });

  static ProductsColorResponse fromJson(Map<String, dynamic> data) => _$ProductsColorResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ProductsColorResponseToJson(this);
}
