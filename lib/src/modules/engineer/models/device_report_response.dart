import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_report_response.g.dart';

@JsonSerializable()
class DeviceReportResponse extends BaseResponse {
  @JsonKey(name: "dt")
  DeviceReportData? deviceReportData;

  DeviceReportResponse(this.deviceReportData, super.cashifyAlert, super.trackUrl);

  static DeviceReportResponse fromJson(Map<String, dynamic> json) => _$DeviceReportResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeviceReportResponseToJson(this);
}

@JsonSerializable()
class DeviceReportData {
  @JsonKey(name: "dr")
  List<DeviceReport>? deviceReportList;

  @JsonKey(name: "tr")
  String? testingRemarks;

  DeviceReportData(this.deviceReportList, this.testingRemarks);

  static DeviceReportData fromJson(Map<String, dynamic> json) => _$DeviceReportDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceReportDataToJson(this);
}

@JsonSerializable()
class DeviceReport {
  @JsonKey(name: "pn")
  String? partName;

  @JsonKey(name: "vn")
  String? variationName;

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "isFail")
  bool? isFail;

  DeviceReport(this.partName, this.variationName, this.id, this.isFail);

  static DeviceReport fromJson(Map<String, dynamic> json) => _$DeviceReportFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceReportToJson(this);
}
