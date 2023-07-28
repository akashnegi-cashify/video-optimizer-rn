import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/address_response.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/vendor_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'suborder_group_list_response.g.dart';

@JsonSerializable()
class SubOrderGroupListResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<SubOrderGroupListData>? subOrderList;

  SubOrderGroupListResponse(this.subOrderList, super.cashifyAlert, super.trackUrl);

  static SubOrderGroupListResponse fromJson(Map<String, dynamic> json) => _$SubOrderGroupListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SubOrderGroupListResponseToJson(this);
}

@JsonSerializable()
class SubOrderGroupListData {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'n')
  String? name;

  @JsonKey(name: 'lt')
  int? lotType;

  @JsonKey(name: 'ltn')
  String? lotTypeName;

  @JsonKey(name: 'pbar')
  String? packagingBarcode;

  SubOrderGroupListData(this.id, this.name, this.lotType, this.lotTypeName, this.packagingBarcode);

  static SubOrderGroupListData fromJson(Map<String, dynamic> json) => _$SubOrderGroupListDataFromJson(json);

  Map<String, dynamic> toJson() => _$SubOrderGroupListDataToJson(this);
}
