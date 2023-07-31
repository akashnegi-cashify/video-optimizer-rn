import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shipment_provider_list_response.g.dart';

@JsonSerializable()
class ShipmentProviderListResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<ShipmentProviderListData>? providerList;

  ShipmentProviderListResponse(this.providerList, super.cashifyAlert, super.trackUrl);

  static ShipmentProviderListResponse fromJson(Map<String, dynamic> json) =>
      _$ShipmentProviderListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShipmentProviderListResponseToJson(this);
}

@JsonSerializable()
class ShipmentProviderListData {
  @JsonKey(name: "k")
  String? key;

  @JsonKey(name: "n")
  String? name;

  static ShipmentProviderListData fromJson(Map<String, dynamic> json) => _$ShipmentProviderListDataFromJson(json);

  Map<String, dynamic> toJson() => _$ShipmentProviderListDataToJson(this);
}
