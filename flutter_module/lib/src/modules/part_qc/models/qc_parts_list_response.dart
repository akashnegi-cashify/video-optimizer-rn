import 'package:json_annotation/json_annotation.dart';

part 'qc_parts_list_response.g.dart';

@JsonSerializable()
class QcPartsListResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "dt")
  List<QcPartListData>? dataList;

  QcPartsListResponse({
    this.refId,
    this.dataList,
  });

  static QcPartsListResponse fromJson(Map<String, dynamic> data) => _$QcPartsListResponseFromJson(data);

  Map<String, dynamic> toJson() => _$QcPartsListResponseToJson(this);
}

@JsonSerializable()
class QcPartListData {
  @JsonKey(name: "prid")
  int? prid;
  @JsonKey(name: "sku")
  String? sku;
  @JsonKey(name: "pn")
  String? partName;
  @JsonKey(name: "st")
  String? status;
  @JsonKey(name: "stc")
  int? statusCode;
  @JsonKey(name: "rqty")
  int? requestedQuantity;
  @JsonKey(name: "pbr")
  String? partBarcode;
  @JsonKey(name: "pc")
  String? partColor;
  @JsonKey(name: "pvn")
  String? partVariantName;

  bool? isDamaged;
  bool? isBulk;

  QcPartListData({
    this.prid,
    this.sku,
    this.partName,
    this.statusCode,
    this.status,
    this.isBulk,
    this.partBarcode,
    this.isDamaged,
    this.requestedQuantity,
    this.partVariantName,
  });

  static QcPartListData fromJson(Map<String, dynamic> data) => _$QcPartListDataFromJson(data);

  Map<String, dynamic> toJson() => _$QcPartListDataToJson(this);
}
