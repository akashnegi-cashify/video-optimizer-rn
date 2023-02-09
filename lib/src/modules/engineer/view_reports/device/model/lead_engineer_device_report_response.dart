import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'lead_engineer_data.dart';

part 'lead_engineer_device_report_response.g.dart';

@JsonSerializable()
class LeadEngineerDeviceReportResponse extends BaseResponse {
  LeadEngineerDeviceReportResponse(super.cashifyAlert, super.trackUrl);

  @JsonKey(name: "r_id")
  String? requestId;

  @JsonKey(name: "dt")
  LeadEngineerData? data;

  static BaseResponse fromJson(Map<String, dynamic> json) => _$LeadEngineerDeviceReportResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LeadEngineerDeviceReportResponseToJson(this);
}
