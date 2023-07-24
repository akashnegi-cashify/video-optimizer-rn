import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'packaging_sub_order_item_list_response.g.dart';

@JsonSerializable()
class PackagingSubOrderItemListResponse extends BaseResponse {
  @JsonKey(name: 'dt')
  List<PackagingSubOrderItemListData>? subOrderItemList;

  PackagingSubOrderItemListResponse(super.cashifyAlert, super.trackUrl);

  static PackagingSubOrderItemListResponse fromJson(Map<String, dynamic> json) =>
      _$PackagingSubOrderItemListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PackagingSubOrderItemListResponseToJson(this);
}

@JsonSerializable()
class PackagingSubOrderItemListData {
  @JsonKey(name: 'pn')
  String? productName;

  @JsonKey(name: 'bn')
  String? brandName;

  @JsonKey(name: 'sd')
  String? status;

  @JsonKey(name: 's')
  int? statusCode;

  @JsonKey(name: 'udid')
  String? udid;

  @JsonKey(name: 'qr_code')
  String? qrCode;

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'qty')
  int? quantity;

  PackagingSubOrderItemListData(
      this.productName, this.brandName, this.status, this.statusCode, this.udid, this.qrCode, this.id, this.quantity);

  static PackagingSubOrderItemListData fromJson(Map<String, dynamic> json) =>
      _$PackagingSubOrderItemListDataFromJson(json);

  Map<String, dynamic> toJson() => _$PackagingSubOrderItemListDataToJson(this);
}
