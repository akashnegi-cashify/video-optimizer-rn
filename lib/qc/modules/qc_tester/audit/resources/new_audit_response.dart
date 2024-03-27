import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_audit_response.g.dart';

@JsonSerializable()
class NewAuditResponse extends BaseResponse {
  @JsonKey(name: "r_id")
  String? referenceId;

  @JsonKey(name: "dt")
  AuditQuestionResponse? auditQuestionResponse;

  NewAuditResponse(super.cashifyAlert, super.trackUrl);

  static NewAuditResponse fromJson(Map<String, dynamic> json) => _$NewAuditResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NewAuditResponseToJson(this);
}

@JsonSerializable()
class AuditQuestionResponse {
  @JsonKey(name: "dpr")
  List<AuditQuestionData>? auditQuestionList;

  @JsonKey(name: "maq")
  List<ManualAuditQuestionItem>? manualAuditQuestionList;

  static AuditQuestionResponse fromJson(Map<String, dynamic> json) => _$AuditQuestionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuditQuestionResponseToJson(this);
}

@JsonSerializable()
class AuditQuestionData {
  @JsonKey(name: "pi")
  int? questionId;

  @JsonKey(name: "pn")
  String? question;

  @JsonKey(name: "ic")
  int? imageCount;

  @JsonKey(name: "v")
  Map<String, String>? options;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? selectedOption;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? s3url;

  @JsonKey(includeFromJson: false, includeToJson: false)
  File? selectedImageFile;

  AuditQuestionData(
    this.questionId,
    this.question,
    this.options, {
    this.selectedOption,
    this.selectedImageFile,
    this.s3url,
  });

  static AuditQuestionData fromJson(Map<String, dynamic> json) => _$AuditQuestionDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuditQuestionDataToJson(this);
}

@JsonSerializable()
class ManualAuditQuestionItem {
  @JsonKey(name: "mmid")
  int? manualMasterId;

  @JsonKey(name: "q")
  String? question;

  @JsonKey(name: "is")
  bool? isSelected;

  ManualAuditQuestionItem(this.manualMasterId, this.question);

  static ManualAuditQuestionItem fromJson(Map<String, dynamic> json) => _$ManualAuditQuestionItemFromJson(json);

  Map<String, dynamic> toJson() => _$ManualAuditQuestionItemToJson(this);
}
