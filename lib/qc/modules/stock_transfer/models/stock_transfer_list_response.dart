import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_transfer_list_response.g.dart';

@JsonSerializable()
class StockTransferListResponse extends BaseResponse {
  @JsonKey(name: "lotDetailsList")
  List<StockTransferListData>? lotList;

  @JsonKey(name: "lotCount")
  int? lotListCount;

  StockTransferListResponse(this.lotList, this.lotListCount, super.cashifyAlert, super.trackUrl);

  static StockTransferListResponse fromJson(Map<String, dynamic> json) => _$StockTransferListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StockTransferListResponseToJson(this);
}

@JsonSerializable()
class StockTransferListData {
  @JsonKey(name: "id")
  int? lotId;

  @JsonKey(name: "na")
  String? lotName;

  @JsonKey(name: "dc")
  int? deviceCount;

  @JsonKey(name: "dst")
  String? destinationFacility;

  @JsonKey(name: "stc")
  int? statusCode;

  @JsonKey(name: "st")
  String? status;

  StockTransferListData(
      {this.lotId, this.lotName, this.deviceCount, this.destinationFacility, this.statusCode, this.status});

  static StockTransferListData fromJson(Map<String, dynamic> json) => _$StockTransferListDataFromJson(json);

  Map<String, dynamic> toJson() => _$StockTransferListDataToJson(this);
}
