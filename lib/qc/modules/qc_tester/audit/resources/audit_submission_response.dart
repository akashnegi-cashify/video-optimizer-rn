import 'package:json_annotation/json_annotation.dart';

part 'audit_submission_response.g.dart';

@JsonSerializable()
class AuditSubmissionResponse {
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "r_id")
  String? referenceId;
  @JsonKey(name: "dt")
  AuditSubmissionResponseData? auditSubmissionData;

  AuditSubmissionResponse(
    this.referenceId,
    this.success,
    this.auditSubmissionData,
  );

  static AuditSubmissionResponse fromJson(Map<String, dynamic> data) => _$AuditSubmissionResponseFromJson(data);

  Map<String, dynamic> toJson() => _$AuditSubmissionResponseToJson(this);
}

@JsonSerializable()
class AuditSubmissionResponseData {
  @JsonKey(name: "r_id")
  String? referenceId;
  @JsonKey(name: "pn")
  String? productName;
  @JsonKey(name: "bn")
  String? brandName;
  @JsonKey(name: "qa")
  double? qa;
  @JsonKey(name: "gr")
  String? grade;
  @JsonKey(name: "ps")
  List<PartsStatus>? partsStatusList;

  AuditSubmissionResponseData(
    this.referenceId,
    this.productName,
    this.brandName,
    this.grade,
    this.partsStatusList,
    this.qa,
  );

  static AuditSubmissionResponseData fromJson(Map<String, dynamic> data) => _$AuditSubmissionResponseDataFromJson(data);

  Map<String, dynamic> toJson() => _$AuditSubmissionResponseDataToJson(this);
}

@JsonSerializable()
class PartsStatus {
  @JsonKey(name: "l")
  String? label;
  @JsonKey(name: "p")
  String? p;

  PartsStatus(
    this.label,
    this.p,
  );

  static PartsStatus fromJson(Map<String, dynamic> data) => _$PartsStatusFromJson(data);

  Map<String, dynamic> toJson() => _$PartsStatusToJson(this);
}
