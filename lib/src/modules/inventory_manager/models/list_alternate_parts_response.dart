import 'package:json_annotation/json_annotation.dart';

part 'list_alternate_parts_response.g.dart';

@JsonSerializable()
class ListAlternatePartsResponse {
  @JsonKey(name: "r_id")
  String? rid;
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "dt")
  List<ListAlternateData>? data;  // Changed field name to 'data' for CshApiList compatibility

  ListAlternatePartsResponse({
    this.isSuccess,
    this.rid,
    this.data,
  });

  static ListAlternatePartsResponse fromJson(Map<String, dynamic> json) => _$ListAlternatePartsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListAlternatePartsResponseToJson(this);
}

@JsonSerializable()
class ListAlternateData {
  @JsonKey(name: "sku")
  String? sku;

  @JsonKey(name: "pn")
  String? productName;

  @JsonKey(name: "pvn")
  String? partVariantName;

  ListAlternateData({
    this.sku,
    this.productName,
    this.partVariantName,
  });

  static ListAlternateData fromJson(Map<String, dynamic> data) => _$ListAlternateDataFromJson(data);

  Map<String, dynamic> toJson() => _$ListAlternateDataToJson(this);
}
