import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_detail_response.g.dart';

@JsonSerializable()
class DeviceDetailResponse extends BaseResponse {
  @JsonKey(name: "dt")
  DeviceDetailResponseData? deviceDetails;

  DeviceDetailResponse(this.deviceDetails, super.cashifyAlert, super.trackUrl);

  static DeviceDetailResponse fromJson(Map<String, dynamic> json) => _$DeviceDetailResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeviceDetailResponseToJson(this);
}

@JsonSerializable()
class DeviceDetailResponseData {
  @JsonKey(name: "qc")
  String? qrCode;

  @JsonKey(name: "imei")
  String? imei1;

  @JsonKey(name: "sn")
  String? serialNo;

  @JsonKey(name: "cat_id")
  int? selectedCategoryId;

  @JsonKey(name: "cat")
  Map<int, String>? categories;

  DeviceDetailResponseData(this.qrCode, this.imei1, this.serialNo, this.selectedCategoryId, this.categories);

  static DeviceDetailResponseData fromJson(Map<String, dynamic> json) => _$DeviceDetailResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceDetailResponseDataToJson(this);
}
