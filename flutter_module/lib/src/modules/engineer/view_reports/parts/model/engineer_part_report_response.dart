import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/modules/engineer/view_reports/parts/model/part_report_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'engineer_part_report_response.g.dart';

@JsonSerializable()
class EngineerPartReportResponse extends BaseActionResponse {
  EngineerPartReportResponse(super.cashifyAlert, super.trackUrl);

  @JsonKey(name: "dt")
  PartReportData? data;

  static EngineerPartReportResponse fromJson(Map<String, dynamic> json) => _$EngineerPartReportResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EngineerPartReportResponseToJson(this);
}
