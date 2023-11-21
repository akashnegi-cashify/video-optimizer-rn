import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'supervisor_device_detail_response.g.dart';

@JsonSerializable()
class SupervisorDeviceDetailResponse extends BaseResponse {
  @JsonKey(name: "dbr")
  String? deviceBarcode;

  @JsonKey(name: "mtb")
  String? manualTestedBy;

  @JsonKey(name: "mta")
  int? manualTestedAt;

  @JsonKey(name: "ctb")
  String? cdpTestedBy;

  @JsonKey(name: "cta")
  int? cdpTestedAt;

  @JsonKey(name: "pv")
  List<PartVariationData>? partVariationListResponse;

  @JsonKey(name: "dm")
  List<DeviceMediaData>? deviceMediaListResponse;

  @JsonKey(name: "dg")
  String? deviceGrade;

  @JsonKey(name: "dgd")
  String? deviceGradeDesc;

  @JsonKey(name: "ds")
  String? deviceStatus;

  SupervisorDeviceDetailResponse(
      this.deviceBarcode,
      this.manualTestedBy,
      this.manualTestedAt,
      this.cdpTestedBy,
      this.cdpTestedAt,
      this.partVariationListResponse,
      this.deviceMediaListResponse,
      this.deviceStatus,
      super.cashifyAlert,
      super.trackUrl);

  static SupervisorDeviceDetailResponse fromJson(Map<String, dynamic> json) =>
      _$SupervisorDeviceDetailResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SupervisorDeviceDetailResponseToJson(this);
}

@JsonSerializable()
class DeviceMediaData {
  @JsonKey(name: "n")
  String? name;

  @JsonKey(name: "p")
  String? path;

  @JsonKey(name: "iv")
  bool? isVideo;

  DeviceMediaData({this.name, this.path, this.isVideo});

  static DeviceMediaData fromJson(Map<String, dynamic> json) => _$DeviceMediaDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceMediaDataToJson(this);
}

@JsonSerializable()
class PartVariationData {
  @JsonKey(name: "pi")
  int? partId;

  @JsonKey(name: "pn")
  String? partName;

  @JsonKey(name: "v")
  Map<String, String>? value;

  @JsonKey(name: "svi")
  int? selectedVariationId;

  @JsonKey(name: "svn")
  String? selectedVariationName;

  @JsonKey(name: "c")
  String? category;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? imageUrl;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? userSelectedVariantId;

  PartVariationData(
      {this.partId, this.partName, this.value, this.selectedVariationId, this.selectedVariationName, this.category});

  static PartVariationData fromJson(Map<String, dynamic> json) => _$PartVariationDataFromJson(json);

  Map<String, dynamic> toJson() => _$PartVariationDataToJson(this);
}
