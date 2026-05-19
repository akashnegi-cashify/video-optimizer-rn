import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/common/model/new_base_action_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'd2c_lot_device_list_response.g.dart';

@JsonSerializable()
class D2cLotDeviceListResponse extends NewBaseActionResponse {
  @JsonKey(name: "dt")
  List<D2cLotDeviceListData>? d2cLotDeviceList;

  D2cLotDeviceListResponse(this.d2cLotDeviceList, super.cashifyAlert, super.trackUrl);

  static D2cLotDeviceListResponse fromJson(Map<String, dynamic> json) => _$D2cLotDeviceListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$D2cLotDeviceListResponseToJson(this);
}

@JsonSerializable()
class D2cLotDeviceListData {
  @JsonKey(name: "qrCode")
  String? deviceBarcode;

  D2cLotDeviceListData(this.deviceBarcode);

  static D2cLotDeviceListData fromJson(Map<String, dynamic> json) => _$D2cLotDeviceListDataFromJson(json);

  Map<String, dynamic> toJson() => _$D2cLotDeviceListDataToJson(this);
}
