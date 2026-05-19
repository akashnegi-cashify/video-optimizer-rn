import 'package:json_annotation/json_annotation.dart';

part 'list_alternate_part_response.g.dart';

@JsonSerializable()
class ListAlternatePartResponse {
  @JsonKey(name: "r_id")
  String? rid;
  @JsonKey(name: "dt")
  ListAlternatePartData? data;

  ListAlternatePartResponse({
    this.rid,
    this.data,
  });

  static ListAlternatePartResponse fromJson(Map<String, dynamic> data) => _$ListAlternatePartResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ListAlternatePartResponseToJson(this);
}

@JsonSerializable()
class ListAlternatePartData {
  @JsonKey(name: "sku")
  String? sku;
  @JsonKey(name: "pn")
  String? productName;

  ListAlternatePartData({
    this.sku,
    this.productName,
  });

  static ListAlternatePartData fromJson(Map<String, dynamic> data) => _$ListAlternatePartDataFromJson(data);

  Map<String, dynamic> toJson() => _$ListAlternatePartDataToJson(this);
}
