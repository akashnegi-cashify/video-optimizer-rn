import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'device_report_data.dart';

part 'engineer_device_report_response.g.dart';

@JsonSerializable()
class EngineerDeviceReportResponse extends BaseActionResponse {
  @JsonKey(name: "dt")
  DeviceReportData? data;

  EngineerDeviceReportResponse(super.cashifyAlert, super.trackUrl);

  static EngineerDeviceReportResponse fromJson(Map<String, dynamic> data) =>
      _$EngineerDeviceReportResponseFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$EngineerDeviceReportResponseToJson(this);
}
