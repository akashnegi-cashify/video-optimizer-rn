import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lot_device_list_response.g.dart';

@JsonSerializable()
class LotDeviceListResponse extends BaseResponse {
  @JsonKey(name: "dt")
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

  @JsonKey(name: 'did')
  int? deviceId;

  @JsonKey(name: 'mpid')
  int? mpid;

  @JsonKey(name: 'qr_code')
  String? qrCode;

  @JsonKey(name: 'm')
  String? model;

  @JsonKey(name: 'b')
  String? brand;

  @JsonKey(name: 'im')
  String? imei;

  @JsonKey(name: 's')
  int? status;

  @JsonKey(name: 'gr')
  String? grade;

  @JsonKey(name: 'pt')
  String? productTitle;

  @JsonKey(name: 'ta')
  int? testAge;

  @JsonKey(name: 'sd')
  String? statusDescription;

  LotDeviceListData(
      {this.id,
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
      this.statusDescription});

  static LotDeviceListData fromJson(Map<String, dynamic> json) => _$LotDeviceListDataFromJson(json);

  Map<String, dynamic> toJson() => _$LotDeviceListDataToJson(this);
}
