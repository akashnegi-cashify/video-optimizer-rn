import 'package:json_annotation/json_annotation.dart';

import 'elss_part.dart';

part 'elss_device_details_response.g.dart';

@JsonSerializable()
class ElssDeviceDetailsResponse {
  @JsonKey(name: "r_id")
  String? referenceId;
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "em")
  String? errorMessage;
  @JsonKey(name: "dt")
  DeviceDetailsData? deviceDetailsData;

  ElssDeviceDetailsResponse(
    this.referenceId,
    this.errorMessage,
    this.isSuccess,
    this.deviceDetailsData,
  );

  static ElssDeviceDetailsResponse fromJson(Map<String, dynamic> data) => _$ElssDeviceDetailsResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ElssDeviceDetailsResponseToJson(this);
}

@JsonSerializable()
class DeviceDetailsData {
  @JsonKey(name: "dna")
  String? deviceName;
  @JsonKey(name: "dbr")
  String? deviceBarcode;
  @JsonKey(name: "dst")
  String? deviceStatus;
  @JsonKey(name: "drt")
  String? deviceRepairType;
  @JsonKey(name: "dgr")
  String? deviceGrade;
  @JsonKey(name: "paal")
  bool? partAdditionAllowed;
  @JsonKey(name: "dcl")
  String? deviceColor;
  @JsonKey(name: "pid")
  int? productId;
  @JsonKey(name: "isDetailsPresent")
  bool? isDetailsPresent;
  @JsonKey(name: "imei")
  String? imei;
  @JsonKey(name: "rr")
  String? requestReason;
  @JsonKey(name: "rrs")
  List<String?>? repairReasonList;
  @JsonKey(name: "rp")
  List<ElssPart>? repairPartList;
  @JsonKey(name: "isr")
  bool? isRubbingRequired;

  @JsonKey(name: "sgr")
  String? suggestedGrade;

  @JsonKey(name: "sgc")
  String? suggestedChannel;

  @JsonKey(name: "imrd")
  bool? isMarkRepairedDevice;

  @JsonKey(name: "sno")
  String? serialNumber;

  @JsonKey(name: "st")
  List<String>? stockTags;

  @JsonKey(name: "rs")
  int? rubbingOrGlassChange;

  @JsonKey(name: "str")
  int? stressTestingResult;

  DeviceDetailsData(
    this.deviceBarcode,
    this.requestReason,
    this.deviceName,
    this.repairReasonList,
    this.productId,
    this.deviceStatus,
    this.deviceColor,
    this.imei,
    this.deviceRepairType,
    this.isDetailsPresent,
    this.repairPartList,
    this.deviceGrade,
    this.partAdditionAllowed,
    this.isRubbingRequired,
    this.suggestedGrade,
    this.suggestedChannel,
    this.isMarkRepairedDevice,
    this.serialNumber,
    this.stockTags,
    this.rubbingOrGlassChange,
    this.stressTestingResult,
  );

  static DeviceDetailsData fromJson(Map<String, dynamic> data) => _$DeviceDetailsDataFromJson(data);

  Map<String, dynamic> toJson() => _$DeviceDetailsDataToJson(this);
}
