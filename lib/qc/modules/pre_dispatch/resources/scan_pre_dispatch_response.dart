import 'package:flutter_trc/qc/modules/re_qc/models/lot_device_list_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scan_pre_dispatch_response.g.dart';

@JsonSerializable()
class ScanPreDispatchResponse {
  @JsonKey(name: "cm")
  String? message;

  @JsonKey(name: "s")
  int? status;

  @JsonKey(name: "success")
  bool? success;

  @JsonKey(name: "tc")
  int? totalCount;

  @JsonKey(name: "em")
  String? errorMessage;

  @JsonKey(includeFromJson: false,includeToJson: false)
  LotDeviceListData? preDispatchItem;

  ScanPreDispatchResponse({
    this.message,
    this.status,
    this.success,
    this.totalCount,
    this.preDispatchItem,
    this.errorMessage,
  });

  static ScanPreDispatchResponse fromJson(Map<String, dynamic> data) => _$ScanPreDispatchResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ScanPreDispatchResponseToJson(this);
}
