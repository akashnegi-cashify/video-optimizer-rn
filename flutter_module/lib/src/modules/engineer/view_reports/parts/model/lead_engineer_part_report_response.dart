import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

import 'lead_engineer_data.dart';
part 'lead_engineer_part_report_response.g.dart';

@JsonSerializable()
class LeadEngineerPartReportResponse extends BaseResponse {
  @JsonKey(name: "r_id")
  String? requestId;

  @JsonKey(name: "dt")
  LeadEngineerData? data;

  LeadEngineerPartReportResponse(super.cashifyAlert, super.trackUrl);

  static LeadEngineerPartReportResponse fromJson(Map<String, dynamic> data) =>
      _$LeadEngineerPartReportResponseFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$LeadEngineerPartReportResponseToJson(this);
}
