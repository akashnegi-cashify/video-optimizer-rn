import 'package:json_annotation/json_annotation.dart';

part 'assigned_part_details_response.g.dart';

@JsonSerializable()
class AssignedPartsDetails {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "dt")
  AssignedPartData? data;

  AssignedPartsDetails({
    this.refId,
    this.data,
  });

  static AssignedPartsDetails fromJson(Map<String, dynamic> data) => _$AssignedPartsDetailsFromJson(data);

  Map<String, dynamic> toJson() => _$AssignedPartsDetailsToJson(this);
}

@JsonSerializable()
class AssignedPartData {
  @JsonKey(name: "prid")
  int? prid;
  @JsonKey(name: "sku")
  String? sku;
  @JsonKey(name: "pn")
  String? productName;
  @JsonKey(name: "pc")
  String? productColour;
  @JsonKey(name: "st")
  String? status;
  @JsonKey(name: "rqty")
  int? requiredQuantity;
  @JsonKey(name: "pbr")
  String? productBarcode;
  @JsonKey(name: "pvn")
  String? partVariantName;

  AssignedPartData({
    this.status,
    this.productName,
    this.sku,
    this.prid,
    this.productColour,
    this.productBarcode,
    this.requiredQuantity,
    this.partVariantName,
  });

  static AssignedPartData fromJson(Map<String, dynamic> data) => _$AssignedPartDataFromJson(data);

  Map<String, dynamic> toJson() => _$AssignedPartDataToJson(this);
}
