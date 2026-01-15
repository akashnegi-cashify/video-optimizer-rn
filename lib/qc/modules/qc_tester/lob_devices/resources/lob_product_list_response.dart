import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lob_product_list_response.g.dart';

@JsonSerializable()
class LobProductListResponse extends BaseResponse {
  @JsonKey(name: 'r_id')
  String? rId;

  @JsonKey(name: 'dt')
  List<LobProductListData>? productList;

  LobProductListResponse(this.rId, this.productList) : super(null, '');

  static LobProductListResponse fromJson(Map<String, dynamic> json) =>
      _$LobProductListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LobProductListResponseToJson(this);
}

@JsonSerializable()
class LobProductListData {
  @JsonKey(name: 'productId')
  int? productId;
  @JsonKey(name: 'productName')
  String? name;
  @JsonKey(name: 'brandId')
  int? brandId;
  @JsonKey(name: 'brandName')
  String? brand;
  @JsonKey(name: 'productMasterId')
  int? productMasterId;

  LobProductListData(this.productId, this.name, this.brandId, this.brand, this.productMasterId);

  static LobProductListData fromJson(Map<String, dynamic> json) =>
      _$LobProductListDataFromJson(json);

  Map<String, dynamic> toJson() => _$LobProductListDataToJson(this);
}
