import 'package:json_annotation/json_annotation.dart';

part 'lot_device_list_response.g.dart';

@JsonSerializable()
class LotDeviceListResponse {
  @JsonKey(name: 'data')
  final List<LotDevice?>? data;

  @JsonKey(name: 'totalCount')
  final int? totalCount;

  LotDeviceListResponse({this.data, this.totalCount});

  static LotDeviceListResponse fromJson(Map<String, dynamic> json) =>
      _$LotDeviceListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LotDeviceListResponseToJson(this);
}

@JsonSerializable()
class LotDevice {
  @JsonKey(name: 'barcode')
  final String? barcode;

  @JsonKey(name: 'productTitle')
  final String? productTitle;

  @JsonKey(name: 'lotItemLocation')
  final String? lotItemLocation;

  LotDevice({
    this.barcode,
    this.productTitle,
    this.lotItemLocation,
  });

  static LotDevice fromJson(Map<String, dynamic> json) => _$LotDeviceFromJson(json);

  Map<String, dynamic> toJson() => _$LotDeviceToJson(this);
}
