import 'package:json_annotation/json_annotation.dart';

part 're_qc_variant_request.g.dart';

@JsonSerializable()
class ReQcVariantRequest {
  @JsonKey(name: "iurl")
  String? imageUrl;

  @JsonKey(name: "vi")
  int? variantId;

  ReQcVariantRequest({this.imageUrl, this.variantId});

  static ReQcVariantRequest fromJson(Map<String, dynamic> json) => _$ReQcVariantRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReQcVariantRequestToJson(this);
}
