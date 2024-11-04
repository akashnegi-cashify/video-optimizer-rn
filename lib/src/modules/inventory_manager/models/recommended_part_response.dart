import 'package:json_annotation/json_annotation.dart';

part 'recommended_part_response.g.dart';

@JsonSerializable()
class RecommendedPartResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "dt")
  List<RecommendedPartData>? dataList;

  RecommendedPartResponse({
    this.isSuccess,
    this.dataList,
    this.refId,
  });

  static RecommendedPartResponse fromJson(Map<String, dynamic> data) => _$RecommendedPartResponseFromJson(data);

  Map<String, dynamic> toJson() => _$RecommendedPartResponseToJson(this);
}

@JsonSerializable()
class RecommendedPartData {
  @JsonKey(name: "rqty")
  int? recommendedQuantity;
  @JsonKey(name: "pbr")
  String? barcode;
  @JsonKey(name: "lc")
  String? location;

  RecommendedPartData({
    this.barcode,
    this.recommendedQuantity,
    this.location,
  });

  static RecommendedPartData fromJson(Map<String, dynamic> data) => _$RecommendedPartDataFromJson(data);

  Map<String, dynamic> toJson() => _$RecommendedPartDataToJson(this);
}
