import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'packaging_sub_order_list_response.g.dart';

@JsonSerializable()
class PackagingSubOrderListResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<PackagingSubOrderListData>? subOrderList;

  PackagingSubOrderListResponse(this.subOrderList, super.cashifyAlert, super.trackUrl);

  static PackagingSubOrderListResponse fromJson(Map<String, dynamic> json) =>
      _$PackagingSubOrderListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PackagingSubOrderListResponseToJson(this);
}

@JsonSerializable()
class PackagingSubOrderListData {
  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "ln")
  String? lotName;

  @JsonKey(name: "inv")
  String? invoiceBarcode;

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "qty")
  int? quantity;

  PackagingSubOrderListData(this.name, this.lotName, this.invoiceBarcode, this.id, this.quantity);

  static PackagingSubOrderListData fromJson(Map<String, dynamic> json) => _$PackagingSubOrderListDataFromJson(json);

  Map<String, dynamic> toJson() => _$PackagingSubOrderListDataToJson(this);
}
