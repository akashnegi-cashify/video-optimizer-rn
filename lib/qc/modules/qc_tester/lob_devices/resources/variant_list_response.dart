import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variant_list_response.g.dart';

@JsonSerializable()
class VariantListResponse extends BaseResponse {
  @JsonKey(name: 'pm')
  int? pm;

  @JsonKey(name: 'dt')
  List<VariantListData>? variantListResponseData;

  VariantListResponse(this.pm, this.variantListResponseData, super.cashifyAlert, super.trackUrl);

  static VariantListResponse fromJson(Map<String, dynamic> json) => _$VariantListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VariantListResponseToJson(this);
}

@JsonSerializable()
class VariantListData {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'commonName')
  String? commonName;

  @JsonKey(name: 'screenSize')
  String? screenSize;

  @JsonKey(name: 'processor')
  String? processor;

  VariantListData(this.id, this.name, this.commonName, this.screenSize, this.processor);

  static VariantListData fromJson(Map<String, dynamic> json) => _$VariantListDataFromJson(json);

  Map<String, dynamic> toJson() => _$VariantListDataToJson(this);
}
