import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_detail_response.g.dart';

@JsonSerializable()
class DeviceDetailResponse extends BaseResponse {
  @JsonKey(name: "data")
  DeviceDetailResponseData? deviceDetails;

  DeviceDetailResponse(this.deviceDetails, super.cashifyAlert, super.trackUrl);

  static DeviceDetailResponse fromJson(Map<String, dynamic> json) => _$DeviceDetailResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeviceDetailResponseToJson(this);
}

@JsonSerializable()
class DeviceDetailResponseData {

  @JsonKey(name: "qrCode")
  String? qrCode;

  @JsonKey(name: "imei")
  String? imei1;

  @JsonKey(name: "imei2")
  String? imei2;

  @JsonKey(name: "serialNo")
  String? serialNo;

  @JsonKey(name: "brandId")
  int? brandId;

  @JsonKey(name: "categoryId")
  int? selectedCategoryId;

  @JsonKey(name: "categories")
  List<CategoryData>? categoryList;

  @JsonKey(name: "remarks")
  Map<String, int>? reasons;

  @JsonKey(name: "isDeviceImeiApproved")
  bool? isDeviceImeiApproved;

  DeviceDetailResponseData(this.qrCode, this.imei1, this.serialNo, this.selectedCategoryId, this.categoryList, this.imei2,
      this.reasons, this.isDeviceImeiApproved, this.brandId);

  static DeviceDetailResponseData fromJson(Map<String, dynamic> json) => _$DeviceDetailResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceDetailResponseDataToJson(this);
}

@JsonSerializable()
class CategoryData {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "apiName")
  String? categoryKey;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "allowVariant")
  bool? allowVariant;

  @JsonKey(name: "allowImei")
  bool? allowImeiSearch;

  CategoryData(this.id, this.name, this.allowVariant, this.allowImeiSearch, this.categoryKey);

  static CategoryData fromJson(Map<String, dynamic> json) => _$CategoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDataToJson(this);
}
