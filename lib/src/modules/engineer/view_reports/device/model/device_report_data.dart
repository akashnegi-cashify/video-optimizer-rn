import 'package:json_annotation/json_annotation.dart';
part 'device_report_data.g.dart';

@JsonSerializable()
class DeviceReportData {
  @JsonKey(name: "tad")
  int? totalAssignDevice;

  @JsonKey(name: "mod")
  int? markedOkDevice;

  @JsonKey(name: "mopd")
  int? markedOkPassDevice;

  @JsonKey(name: "mofd")
  int? markedOkFailDevice;

  @JsonKey(name: "eff")
  double? efficiency;

  @JsonKey(name: "avgrt")
  int? avgRepairTime;


  static DeviceReportData fromJson(Map<String, dynamic> data) => _$DeviceReportDataFromJson(data);

  Map<String, dynamic> toJson() => _$DeviceReportDataToJson(this);
}
