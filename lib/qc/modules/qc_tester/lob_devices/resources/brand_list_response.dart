import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand_list_response.g.dart';

@JsonSerializable()
class BrandListResponse extends BaseResponse {
  @JsonKey(name: 'dt')
  List<BrandListData>? brandList;

  BrandListResponse(this.brandList, super.cashifyAlert, super.trackUrl);

  static BrandListResponse fromJson(Map<String, dynamic> json) => _$BrandListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BrandListResponseToJson(this);
}

@JsonSerializable()
class BrandListData {
  @JsonKey(name: 'bid')
  int? brandId;

  @JsonKey(name: 'bn')
  String? brandName;

  BrandListData(this.brandId, this.brandName);

  static BrandListData fromJson(Map<String, dynamic> json) => _$BrandListDataFromJson(json);

  Map<String, dynamic> toJson() => _$BrandListDataToJson(this);
}
