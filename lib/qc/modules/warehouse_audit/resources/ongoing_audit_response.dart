import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ongoing_audit_response.g.dart';

@JsonSerializable()
class OnGoingAuditResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<OnGoingAuditData>? onGoingAuditList;

  OnGoingAuditResponse(this.onGoingAuditList, super.cashifyAlert, super.trackUrl);

  static OnGoingAuditResponse fromJson(Map<String, dynamic> json) => _$OnGoingAuditResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OnGoingAuditResponseToJson(this);
}

@JsonSerializable()
class OnGoingAuditData {
  @JsonKey(name: "aid")
  int? auditId;

  @JsonKey(name: "fn")
  String? facilityName;

  @JsonKey(name: "s")
  int? status;

  @JsonKey(name: "std")
  String? statusDescription;

  @JsonKey(name: "rm")
  String? message;

  @JsonKey(name: "sd")
  double? startDate;

  @JsonKey(name: "ed")
  double? endDate;

  OnGoingAuditData(
      this.auditId, this.facilityName, this.status, this.statusDescription, this.message, this.startDate, this.endDate);

  static OnGoingAuditData fromJson(Map<String, dynamic> json) => _$OnGoingAuditDataFromJson(json);

  Map<String, dynamic> toJson() => _$OnGoingAuditDataToJson(this);
}
