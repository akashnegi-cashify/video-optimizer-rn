import 'package:json_annotation/json_annotation.dart';

part 'list_alternate_parts_response.g.dart';

@JsonSerializable()
class ListAlternatePartsResponse {
  @JsonKey(name: "r_id")
  String? rid;
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "dt")
  List<ListAlternateData>? dataList;

  ListAlternatePartsResponse({
    this.isSuccess,
    this.rid,
    this.dataList,
  });

  static ListAlternatePartsResponse fromJson(Map<String, dynamic> data) => _$ListAlternatePartsResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ListAlternatePartsResponseToJson(this);
}

@JsonSerializable()
class ListAlternateData {
  @JsonKey(name: "sku")
  String? sku;
  @JsonKey(name: "pn")
  String? productName;

  ListAlternateData({
    this.sku,
    this.productName,
  });

  static ListAlternateData fromJson(Map<String, dynamic> data) => _$ListAlternateDataFromJson(data);

  Map<String, dynamic> toJson() => _$ListAlternateDataToJson(this);
}
