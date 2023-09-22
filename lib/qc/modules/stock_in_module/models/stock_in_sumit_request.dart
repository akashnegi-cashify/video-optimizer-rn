import 'package:json_annotation/json_annotation.dart';

import 'awb_selection_request.dart';

part 'stock_in_submit_request.g.dart';

@JsonSerializable()
class StockInSubmitRequest {
  @JsonKey(name: "awb")
  String? awbNumber;

  @JsonKey(name: "qrcode")
  String? qrcode;

  @JsonKey(name: "selection")
  List<SelectionData>? imgList;

  @JsonKey(name: "bctr")
  AccessoriesData? barcodeChargerTracking;

  static StockInSubmitRequest fromJson(Map<String, dynamic> data) => _$StockInSubmitRequestFromJson(data);

  Map<String, dynamic> toJson() => _$StockInSubmitRequestToJson(this);
}
