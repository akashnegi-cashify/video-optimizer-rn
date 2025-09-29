import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/shipment_provider_list_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expected_shipment_provider_response.g.dart';

@JsonSerializable()
class ExpectedShipmentProviderResponse extends BaseResponse {
  @JsonKey(name: "dt")
  ShipmentProviderListData? expectedProvider;

  ExpectedShipmentProviderResponse(this.expectedProvider, super.cashifyAlert, super.trackUrl);

  static ExpectedShipmentProviderResponse fromJson(Map<String, dynamic> json) =>
      _$ExpectedShipmentProviderResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExpectedShipmentProviderResponseToJson(this);
}
