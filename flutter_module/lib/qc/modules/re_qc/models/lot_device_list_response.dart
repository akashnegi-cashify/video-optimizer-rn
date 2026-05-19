import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lot_device_list_response.g.dart';

@JsonSerializable()
class LotDeviceListResponse extends BaseResponse {
  @JsonKey(name: "data")
  List<LotDeviceListData>? deviceList;

  LotDeviceListResponse(this.deviceList, super.cashifyAlert, super.trackUrl);

  static LotDeviceListResponse fromJson(Map<String, dynamic> json) => _$LotDeviceListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LotDeviceListResponseToJson(this);
}

@JsonSerializable()
class LotDeviceListData {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'deviceId')
  int? deviceId;

  @JsonKey(name: 'mpId')
  int? mpid;

  @JsonKey(name: 'qrCode')
  String? qrCode;

  @JsonKey(name: 'model')
  String? model;

  @JsonKey(name: 'brand')
  String? brand;

  @JsonKey(name: 'imei')
  String? imei;

  @JsonKey(name: 'imei1')
  String? imei1;

  @JsonKey(name: 'imei2')
  String? imei2;

  @JsonKey(name: 'serialNumber')
  String? serialNumber;

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'grade')
  String? grade;

  @JsonKey(name: 'productTitle')
  String? productTitle;

  @JsonKey(name: 'testingAge')
  int? testAge;

  @JsonKey(name: 'statusDesc')
  String? statusDescription;

  @JsonKey(name: 'lotId')
  int? lotId;

  @JsonKey(name: 'lotGroupName')
  String? lotGroupName;

  LotDeviceListData({
    this.id,
    this.deviceId,
    this.mpid,
    this.qrCode,
    this.model,
    this.brand,
    this.imei,
    this.status,
    this.grade,
    this.productTitle,
    this.testAge,
    this.statusDescription,
    this.imei1,
    this.imei2,
    this.serialNumber,
    this.lotId,
    this.lotGroupName,
  });

  static LotDeviceListData fromJson(Map<String, dynamic> json) => _$LotDeviceListDataFromJson(json);

  Map<String, dynamic> toJson() => _$LotDeviceListDataToJson(this);
}
