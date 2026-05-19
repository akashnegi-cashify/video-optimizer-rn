import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manual_question_list_response.g.dart';

@JsonSerializable()
class ManualQuestionListResponse extends BaseResponse {

  @JsonKey(name: "dt")
  List<ManualQuestionListData>? questionList;

  ManualQuestionListResponse(super.cashifyAlert, super.trackUrl, this.questionList);

  static ManualQuestionListResponse fromJson(Map<String, dynamic> json) => _$ManualQuestionListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ManualQuestionListResponseToJson(this);
}

@JsonSerializable()
class ManualQuestionListData {

  @JsonKey(name: "q")
  String? question;

  @JsonKey(name: "a")
  int? value;

  ManualQuestionListData(this.question);

  static ManualQuestionListData fromJson(Map<String, dynamic> json) => _$ManualQuestionListDataFromJson(json);

  Map<String, dynamic> toJson() => _$ManualQuestionListDataToJson(this);
}