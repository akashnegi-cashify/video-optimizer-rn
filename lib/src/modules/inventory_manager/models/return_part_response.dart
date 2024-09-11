import 'package:json_annotation/json_annotation.dart';

part 'return_part_response.g.dart';

@JsonSerializable()
class ReturnPartResponse {
  @JsonKey(name: "r_id")
  String? refid;
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "dt")
  ReturnItemPageData? listData;

  ReturnPartResponse({
    this.isSuccess,
    this.refid,
    this.listData,
  });

  static ReturnPartResponse fromJson(Map<String, dynamic> data) => _$ReturnPartResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ReturnPartResponseToJson(this);
}

@JsonSerializable()
class ReturnItemData {
  @JsonKey(name: "prid")
  int? prid;
  @JsonKey(name: "sku")
  String? sku;
  @JsonKey(name: "pn")
  String? productName;
  @JsonKey(name: "st")
  String? status;
  @JsonKey(name: "stc")
  int? statusCode;
  @JsonKey(name: "rqty")
  int? requestedQuantity;
  @JsonKey(name: "pbr")
  String? productBarcode;
  @JsonKey(name: "isDamaged")
  bool? isDamaged;
  @JsonKey(name: "isBulk")
  bool? isBulk;
  @JsonKey(name: "pvn")
  String? partVariantName;

  ReturnItemData({
    this.statusCode,
    this.prid,
    this.status,
    this.productBarcode,
    this.sku,
    this.productName,
    this.isBulk,
    this.isDamaged,
    this.requestedQuantity,
    this.partVariantName,
  });

  static ReturnItemData fromJson(Map<String, dynamic> data) => _$ReturnItemDataFromJson(data);

  Map<String, dynamic> toJson() => _$ReturnItemDataToJson(this);
}

@JsonSerializable()
class ReturnItemPageData {
  @JsonKey(name: "pl")
  List<ReturnItemData>? listOfData;
  @JsonKey(name: "tp")
  int? totalPage;
  @JsonKey(name: "tr")
  int? totalRecord;

  ReturnItemPageData({
    this.totalPage,
    this.listOfData,
    this.totalRecord,
  });

  static ReturnItemPageData fromJson(Map<String, dynamic> data) => _$ReturnItemPageDataFromJson(data);

  Map<String, dynamic> toJson() => _$ReturnItemPageDataToJson(this);
}
