import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_partner_list_response.g.dart';

@JsonSerializable()
class DeliveryPartnerListResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<DeliveryPartnerListData>? deliveryPartnerList;

  DeliveryPartnerListResponse(this.deliveryPartnerList, super.cashifyAlert, super.trackUrl);

  static DeliveryPartnerListResponse fromJson(Map<String, dynamic> json) => _$DeliveryPartnerListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeliveryPartnerListResponseToJson(this);
}

@JsonSerializable()
class DeliveryPartnerListData {
  @JsonKey(name: "n")
  String? name;

  @JsonKey(name: "k")
  String? key;

  @JsonKey(name: "c")
  int? count;

  DeliveryPartnerListData(this.name, this.key);

  static DeliveryPartnerListData fromJson(Map<String, dynamic> json) => _$DeliveryPartnerListDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryPartnerListDataToJson(this);
}
