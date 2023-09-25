import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_report_list_response.g.dart';

@JsonSerializable()
class DeviceReportListResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<DeviceReportListData>? deviceReportList;

  DeviceReportListResponse(this.deviceReportList, super.cashifyAlert, super.trackUrl);

  static DeviceReportListResponse fromJson(Map<String, dynamic> json) => _$DeviceReportListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeviceReportListResponseToJson(this);
}

@JsonSerializable()
class DeviceReportListData {
  @JsonKey(name: "pi")
  int? partId;

  @JsonKey(name: "pn")
  String? label;

  @JsonKey(name: "ic")
  int? imageCount;

  @JsonKey(name: "svi")
  int? selectedVariantId;

  @JsonKey(name: "svn")
  String? selectedVariantName;

  @JsonKey(name: "v")
  Map<String, String>? variation;

  DeviceReportListData(
      {this.partId,
      this.label,
      this.imageCount,
      this.selectedVariantId,
      this.selectedVariantName,
      this.variation});

  static DeviceReportListData fromJson(Map<String, dynamic> json) => _$DeviceReportListDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceReportListDataToJson(this);
}
