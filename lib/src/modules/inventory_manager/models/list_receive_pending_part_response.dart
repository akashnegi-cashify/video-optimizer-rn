import 'package:json_annotation/json_annotation.dart';

part 'list_receive_pending_part_response.g.dart';

@JsonSerializable()
class ListReceivePendingPartResponse {
  @JsonKey(name: "r_id")
  String? rid;
  @JsonKey(name: "data")
  List<ListResponsePendingDataResponse>? dataList;

  ListReceivePendingPartResponse({
    this.rid,
    this.dataList,
  });

  static ListReceivePendingPartResponse fromJson(Map<String, dynamic> data) =>
      _$ListReceivePendingPartResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ListReceivePendingPartResponseToJson(this);
}

@JsonSerializable()
class ListResponsePendingDataResponse {
  @JsonKey(name: "prid")
  int? prid;

  @JsonKey(name: "isUrgent")
  bool? isUrgent;

  @JsonKey(name: "rt")
  String? requestType;

  @JsonKey(name: "st")
  String? status;

  @JsonKey(name: "stc")
  int? statusCode;

  @JsonKey(name: "updby")
  String? updatedBy;

  @JsonKey(name: "updat")
  String? updatedAt;

  @JsonKey(name: "dna")
  String? deviceName;

  @JsonKey(name: "dbr")
  String? deviceBarcode;

  @JsonKey(name: "sku")
  String? sku;

  @JsonKey(name: "pn")
  String? partName;

  @JsonKey(name: "pc")
  String? partColor;

  @JsonKey(name: "pvn")
  String? partVariant;

  @JsonKey(name: "pbr")
  String? partBarcode;

  @JsonKey(name: "rqty")
  int? requestedQty;

  @JsonKey(name: "aqty")
  int? availableQty;

  @JsonKey(name: "isDamaged")
  bool? isDamaged;

  @JsonKey(name: "isBulk")
  bool? isBulk;

  @JsonKey(name: "rvc")
  int? retrievedImages;

  @JsonKey(name: "lc")
  String? location;

  @JsonKey(name: "apn")
  String? altPartName;

  @JsonKey(name: "asku")
  String? altPartSku;

  @JsonKey(name: "apc")
  String? altPartColor;

  @JsonKey(name: "apvn")
  String? altPartVariation;

  @JsonKey(name: "ast")
  String? altPartStatus;

  ListResponsePendingDataResponse({
    this.prid,
    this.isUrgent,
    this.requestType,
    this.status,
    this.statusCode,
    this.updatedBy,
    this.updatedAt,
    this.deviceName,
    this.deviceBarcode,
    this.sku,
    this.partName,
    this.partColor,
    this.partVariant,
    this.partBarcode,
    this.requestedQty,
    this.availableQty,
    this.isDamaged,
    this.isBulk,
    this.retrievedImages,
    this.location,
    this.altPartName,
    this.altPartSku,
    this.altPartColor,
    this.altPartVariation,
    this.altPartStatus,
  });

  static ListResponsePendingDataResponse fromJson(Map<String, dynamic> data) =>
      _$ListResponsePendingDataResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ListResponsePendingDataResponseToJson(this);
}
