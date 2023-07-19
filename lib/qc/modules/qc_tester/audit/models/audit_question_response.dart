import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audit_question_response.g.dart';

@JsonSerializable()
class AuditQuestionResponse extends BaseResponse {
  @JsonKey(name: "r_id")
  String? referenceId;
  @JsonKey(name: "tc")
  int? totalCount;
  @JsonKey(name: "pm")
  int? pm;
  @JsonKey(name: "dt")
  List<AuditQuestionData>? questionList;
  @JsonKey(name: "ic")
  int? isCompleted;
  @JsonKey(name: "message")
  String? message;

  AuditQuestionResponse(
    this.totalCount,
    this.pm,
    this.referenceId,
    this.questionList,
    this.isCompleted,
    this.message,
    super.cashifyAlert,
    super.trackUrl,
  );

  static AuditQuestionResponse fromJson(Map<String, dynamic> json) => _$AuditQuestionResponseFromJson(json);

  @override
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
