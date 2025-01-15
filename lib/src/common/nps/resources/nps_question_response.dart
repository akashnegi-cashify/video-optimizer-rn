import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nps_question_response.g.dart';

@JsonSerializable()
class NpsQuestionResponse extends BaseResponse {

  @JsonKey(name: "dt")
  NpsResponseData? npsResponse;

  NpsQuestionResponse(super.cashifyAlert, super.trackUrl);

  static NpsQuestionResponse fromJson(Map<String, dynamic> json) => _$NpsQuestionResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NpsQuestionResponseToJson(this);
}

@JsonSerializable()
class NpsResponseData {
  @JsonKey(name: "questions")
  List<NpsQuestionData>? questionList;

  static NpsResponseData fromJson(Map<String, dynamic> json) => _$NpsResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$NpsResponseDataToJson(this);
}

@JsonSerializable()
class NpsQuestionData {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "questionId")
  int? questionId;

  @JsonKey(name: "statement")
  String? statement;

  @JsonKey(name: "questionTypekey")
  String? questionTypeKey;

  @JsonKey(name: "questionTypeTitle")
  String? questionTypeTitle;

  @JsonKey(name: "questionOptions")
  List<NpsQuestionData>? questionOptions;

  @JsonKey(includeToJson: false, includeFromJson: false)
  bool? isSelected;

  @JsonKey(includeToJson: false, includeFromJson: false)
  String? textValue;

  NpsQuestionData(this.questionId, this.statement, this.questionTypeKey, this.questionTypeTitle, this.questionOptions);

  static NpsQuestionData fromJson(Map<String, dynamic> json) => _$NpsQuestionDataFromJson(json);

  Map<String, dynamic> toJson() => _$NpsQuestionDataToJson(this);
}
