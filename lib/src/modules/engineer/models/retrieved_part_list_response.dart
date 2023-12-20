import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'retrieved_part_list_response.g.dart';

@JsonSerializable()
class RetrievedPartListResponse extends BaseResponse {

  @JsonKey(name: "dt")
  List<RetrievedPartListData>? retrievedPartListData;

  RetrievedPartListResponse(super.cashifyAlert, super.trackUrl);

  static RetrievedPartListResponse fromJson(Map<String, dynamic> json) => _$RetrievedPartListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RetrievedPartListResponseToJson(this);
}

@JsonSerializable()
class RetrievedPartListData {
  @JsonKey(name: "sku")
  String? sku;

  @JsonKey(name: "pn")
  String? partName;

  @JsonKey(name: "dbr")
  String? deviceBarcode;

  @JsonKey(name: "rpbr")
  String? retrievedPartBarcode;

  RetrievedPartListData(this.sku, this.partName, this.deviceBarcode, this.retrievedPartBarcode);

  static RetrievedPartListData fromJson(Map<String, dynamic> json) => _$RetrievedPartListDataFromJson(json);

  Map<String, dynamic> toJson() => _$RetrievedPartListDataToJson(this);
}
