import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_detail_response.g.dart';

@JsonSerializable()
class DeviceDetailResponse extends BaseResponse {
  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "repairStatus")
  String? repairStatus;

  @JsonKey(name: "salesChannels")
  List<String>? channelList;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "stockAge")
  int? stockAge;

  @JsonKey(name: "barCode")
  String? barcode;

  @JsonKey(name: "model")
  String? modelName;

  @JsonKey(name: "imei")
  String? imei;

  @JsonKey(name: "serialNo")
  String? serialNo;

  @JsonKey(name: "location")
  String? location;

  @JsonKey(name: "lotName")
  String? lotName;

  @JsonKey(name: "storageType")
  String? storageType;

  DeviceDetailResponse(
      this.status,
      this.repairStatus,
      this.channelList,
      this.message,
      this.stockAge,
      this.barcode,
      this.modelName,
      this.imei,
      this.serialNo,
      this.location,
      this.lotName,
      this.storageType,
      super.cashifyAlert,
      super.trackUrl);

  static DeviceDetailResponse fromJson(Map<String, dynamic> json) => _$DeviceDetailResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeviceDetailResponseToJson(this);
}
