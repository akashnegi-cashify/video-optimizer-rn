import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collected_order_list_response.g.dart';

@JsonSerializable()
class CollectedOrderListResponse extends BaseResponse {
  @JsonKey(name: "col")
  List<CollectedOrderListData>? collectedOrderList;

  @JsonKey(name: "anl")
  List<String>? deliveryAgentList;

  CollectedOrderListResponse(this.collectedOrderList, this.deliveryAgentList, super.cashifyAlert, super.trackUrl);

  static CollectedOrderListResponse fromJson(Map<String, dynamic> json) => _$CollectedOrderListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CollectedOrderListResponseToJson(this);
}

@JsonSerializable()
class CollectedOrderListData {
  @JsonKey(name: "an")
  String? deliveryAgentName;

  @JsonKey(name: "tm")
  int? time;

  @JsonKey(name: "dc")
  int? quantity;

  @JsonKey(name: "un")
  String? entryByUserName;

  @JsonKey(name: "fn")
  String? facilityName;

  @JsonKey(name: "im")
  String? imgUrl;

  CollectedOrderListData(
      {this.deliveryAgentName, this.time, this.quantity, this.entryByUserName, this.facilityName, this.imgUrl});

  static CollectedOrderListData fromJson(Map<String, dynamic> json) => _$CollectedOrderListDataFromJson(json);

  Map<String, dynamic> toJson() => _$CollectedOrderListDataToJson(this);
}
