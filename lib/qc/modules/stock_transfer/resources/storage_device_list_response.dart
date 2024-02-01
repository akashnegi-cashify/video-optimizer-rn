import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/st_lot_details_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'storage_device_list_response.g.dart';

@JsonSerializable()
class StorageDeviceListResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<StLotDetailResponse>? deviceList;

  @JsonKey(name: "tc")
  int? totalCount;

  StorageDeviceListResponse(this.deviceList, this.totalCount, super.cashifyAlert, super.trackUrl);

  static StorageDeviceListResponse fromJson(Map<String, dynamic> json) => _$StorageDeviceListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StorageDeviceListResponseToJson(this);
}
