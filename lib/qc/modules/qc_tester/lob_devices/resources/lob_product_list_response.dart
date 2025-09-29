import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lob_product_list_response.g.dart';

@JsonSerializable()
class LobProductListResponse extends BaseResponse {
  @JsonKey(name: 'r_id')
  String? rId;

  @JsonKey(name: 'dt')
  List<LobProductListData>? productList;

  @JsonKey(name: 'tc')
  int? tc;

  LobProductListResponse(this.rId, this.productList, this.tc) : super(null, '');

  static LobProductListResponse fromJson(Map<String, dynamic> json) => _$LobProductListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LobProductListResponseToJson(this);
}

@JsonSerializable()
class LobProductListData {
  @JsonKey(name: 'id')
  int? productId;
  @JsonKey(name: 'n')
  String? name;
  @JsonKey(name: 'bid')
  int? brandId;
  @JsonKey(name: 'b')
  String? brand;
  @JsonKey(name: 'pmid')
  int? productMasterId;

  LobProductListData(this.productId, this.name, this.brandId, this.brand, this.productMasterId);

  static LobProductListData fromJson(Map<String, dynamic> json) => _$LobProductListDataFromJson(json);

  Map<String, dynamic> toJson() => _$LobProductListDataToJson(this);
}
