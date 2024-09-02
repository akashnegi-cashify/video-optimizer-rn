import 'package:json_annotation/json_annotation.dart';

part 'parts_details_response.g.dart';

@JsonSerializable()
class PartsDetailsResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "dt")
  PartDetailsData? partsDetails;

  PartsDetailsResponse({
    this.isSuccess,
    this.refId,
    this.partsDetails,
  });

  static PartsDetailsResponse fromJson(Map<String, dynamic> data) => _$PartsDetailsResponseFromJson(data);

  Map<String, dynamic> toJson() => _$PartsDetailsResponseToJson(this);
}

@JsonSerializable()
class PartDetailsData {
  @JsonKey(name: "prid")
  int? prid;
  @JsonKey(name: "sku")
  String? sku;
  @JsonKey(name: "pn")
  String? partName;
  @JsonKey(name: "pc")
  String? partColor;
  @JsonKey(name: "st")
  String? partStatus;
  @JsonKey(name: "rqty")
  int? requestQuantity;
  @JsonKey(name: "pbr")
  String? barcode;
  @JsonKey(name: "apn")
  String? alternatePartName;
  @JsonKey(name: "asku")
  String? alternatePartSku;
  @JsonKey(name: "ast")
  String? alternatePartStatus;
  @JsonKey(name: "pvn")
  String? partVariantName;

  PartDetailsData({
    this.barcode,
    this.prid,
    this.sku,
    this.partStatus,
    this.partName,
    this.partColor,
    this.requestQuantity,
    this.alternatePartName,
    this.alternatePartSku,
    this.alternatePartStatus,
    this.partVariantName,
  });

  static PartDetailsData fromJson(Map<String, dynamic> data) => _$PartDetailsDataFromJson(data);

  Map<String, dynamic> toJson() => _$PartDetailsDataToJson(this);
}
