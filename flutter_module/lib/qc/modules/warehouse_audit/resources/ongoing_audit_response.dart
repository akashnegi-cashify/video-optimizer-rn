import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ongoing_audit_response.g.dart';

@JsonSerializable()
class OnGoingAuditResponse extends BaseResponse {
  @JsonKey(name: "data")
  List<OnGoingAuditData>? onGoingAuditList;

  OnGoingAuditResponse(this.onGoingAuditList, super.cashifyAlert, super.trackUrl);

  static OnGoingAuditResponse fromJson(Map<String, dynamic> json) => _$OnGoingAuditResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OnGoingAuditResponseToJson(this);
}

@JsonSerializable()
class OnGoingAuditData {
  @JsonKey(name: "id")
  int? auditId;

  @JsonKey(name: "facilityName")
  String? facilityName;

  @JsonKey(name: "status")
  int? status;

  @JsonKey(name: "statusDesc")
  String? statusDescription;

  @JsonKey(name: "remark")
  String? message;

  @JsonKey(name: "startDate")
  double? startDate;

  @JsonKey(name: "endDate")
  double? endDate;

  OnGoingAuditData(
      this.auditId, this.facilityName, this.status, this.statusDescription, this.message, this.startDate, this.endDate);

  static OnGoingAuditData fromJson(Map<String, dynamic> json) => _$OnGoingAuditDataFromJson(json);

  Map<String, dynamic> toJson() => _$OnGoingAuditDataToJson(this);
}
