import 'package:json_annotation/json_annotation.dart';

part 'device_dead_repair_reason_list_response.g.dart';

@JsonSerializable()
class DeviceDeadRepairReasonListResponse {
  @JsonKey(name: "dt")
  List<String?>? data;

  @JsonKey(name: 'success')
  bool? success;

  @JsonKey(name: 's')
  int? status;

  @JsonKey(name: 'message')
  String? message;

  DeviceDeadRepairReasonListResponse({this.data});

  static DeviceDeadRepairReasonListResponse fromJson(Map<String, dynamic> data) => _$DeviceDeadRepairReasonListResponseFromJson(data);

  Map<String, dynamic> toJson() => _$DeviceDeadRepairReasonListResponseToJson(this);

  bool isValid(){
    return status == 1;
  }
}
