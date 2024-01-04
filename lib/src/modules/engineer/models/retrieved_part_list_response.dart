import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'retrieved_part_list_response.g.dart';

@JsonSerializable()
class RetrievedPartListResponse extends BaseResponse {
  @JsonKey(name: "dt")
  RetrievedPartList? retrievedPartListResponse;

  RetrievedPartListResponse(super.cashifyAlert, super.trackUrl);

  static RetrievedPartListResponse fromJson(Map<String, dynamic> json) => _$RetrievedPartListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RetrievedPartListResponseToJson(this);
}

@JsonSerializable()
class RetrievedPartList {
  @JsonKey(name: "dl")
  List<RetrievedPartListData>? retrievedPartList;

  static RetrievedPartList fromJson(Map<String, dynamic> json) => _$RetrievedPartListFromJson(json);

  Map<String, dynamic> toJson() => _$RetrievedPartListToJson(this);
}

@JsonSerializable()
class RetrievedPartListData {
  @JsonKey(name: "prid")
  int? partId;

  @JsonKey(name: "sku")
  String? sku;

  @JsonKey(name: "pn")
  String? partName;

  @JsonKey(name: "dbr")
  String? deviceBarcode;

  @JsonKey(name: "rpbr")
  String? retrievedPartBarcode;

  @JsonKey(name: "rr")
  String? reason;

  @JsonKey(name: "rm")
  String? remark;

  @JsonKey(name: "imgs")
  List<String>? imageUrls;

  RetrievedPartListData(
    this.sku,
    this.partName,
    this.deviceBarcode,
    this.retrievedPartBarcode,
    this.partId,
    this.reason,
    this.imageUrls,
    this.remark,
  );

  static RetrievedPartListData fromJson(Map<String, dynamic> json) => _$RetrievedPartListDataFromJson(json);

  Map<String, dynamic> toJson() => _$RetrievedPartListDataToJson(this);
}
