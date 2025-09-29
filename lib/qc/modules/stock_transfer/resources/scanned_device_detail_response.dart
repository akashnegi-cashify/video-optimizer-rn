import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scanned_device_detail_response.g.dart';

@JsonSerializable()
class ScannedDeviceDetailResponse extends BaseResponse {
  @JsonKey(name: "error")
  bool? isError;

  @JsonKey(name: "ermsg")
  String? errorMsg;

  @JsonKey(name: "mo")
  String? modal;

  @JsonKey(name: "br")
  String? brand;

  @JsonKey(name: "st")
  String? status;

  @JsonKey(name: "src")
  String? source;

  @JsonKey(name: "el")
  int? eligible;

  ScannedDeviceDetailResponse(this.isError, this.errorMsg, this.modal, this.brand, this.status, this.source,
      this.eligible, super.cashifyAlert, super.trackUrl);

  static ScannedDeviceDetailResponse fromJson(Map<String, dynamic> json) => _$ScannedDeviceDetailResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScannedDeviceDetailResponseToJson(this);
}
