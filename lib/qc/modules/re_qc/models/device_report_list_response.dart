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

  @JsonKey(name: "partId")
  int? partId;

  @JsonKey(name: "partName")
  String? label;

  @JsonKey(name: "imageCount")
  int? imageCount;

  @JsonKey(name: "selectedVariationId")
  int? preSelectedVariantId;

  @JsonKey(name: "selectedVariationName")
  String? preSelectedVariantName;

  @JsonKey(name: "value")
  Map<String, String>? variation;

  @JsonKey(includeToJson: false, includeFromJson: false)
  String? userSelectedVariantId;

  @JsonKey(includeToJson: false, includeFromJson: false)
  String? imageUrl;

  DeviceReportListData(
      {this.partId,
      this.label,
      this.imageCount,
      this.preSelectedVariantId,
      this.preSelectedVariantName,
      this.variation});

  static DeviceReportListData fromJson(Map<String, dynamic> json) => _$DeviceReportListDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceReportListDataToJson(this);

  void setInitialUserSelectedVariantId() {
    userSelectedVariantId = preSelectedVariantId?.toString() ?? getVariantKey(0);
  }

  String getVariantKey(int index) {
    return variation!.keys.toList()[index];
  }

  String getVariantValue(String variantId) {
    return variation![variantId] ?? "";
  }

  bool isSelected(String variantId) {
    return variantId == userSelectedVariantId.toString();
  }

  bool isMismatchMarked() {
    return preSelectedVariantId.toString() != userSelectedVariantId;
  }

}
