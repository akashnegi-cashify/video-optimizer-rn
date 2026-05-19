import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'return_part_response.g.dart';

@JsonSerializable()
class ReturnPartResponse {
  @JsonKey(name: "r_id")
  String? refid;
  @JsonKey(name: "dt")
  ReturnItemPageData? listData;

  ReturnPartResponse({
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
  int? updatedAt;
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
  String? partVariantName;
  @JsonKey(name: "pbr")
  String? partBarcode;
  @JsonKey(name: "rqty")
  int? requestedQuantity;
  @JsonKey(name: "aqty")
  int? availableQuantity;
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

  ReturnItemData({
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
    this.partVariantName,
    this.partBarcode,
    this.requestedQuantity,
    this.availableQuantity,
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

// Wrapper response model for CshApiList
@JsonSerializable()
class ReturnPartListApiResponse extends BaseResponse {
  @JsonKey(name: "data")
  List<ReturnItemData>? data;

  ReturnPartListApiResponse(super.cashifyAlert, super.trackUrl);

  // Custom fromJson to convert ReturnPartResponse to ReturnPartListApiResponse
  static ReturnPartListApiResponse fromReturnPartResponse(ReturnPartResponse? response) {
    if (response == null) {
      return ReturnPartListApiResponse(null, null);
    }
    final apiResponse = ReturnPartListApiResponse(null, null);
    apiResponse.data = response.listData?.listOfData;
    return apiResponse;
  }

  static ReturnPartListApiResponse fromJson(Map<String, dynamic> json) => _$ReturnPartListApiResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReturnPartListApiResponseToJson(this);
}
