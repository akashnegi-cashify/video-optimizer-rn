import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calculator_submit_response.g.dart';

@JsonSerializable()
class CalculatorSubmitResponse extends BaseResponse {

  @JsonKey(name: "gr")
  String? grade;

  @JsonKey(name: "cm")
  String? cautionMessage;

  CalculatorSubmitResponse(this.grade, this.cautionMessage, super.cashifyAlert, super.trackUrl);

  static CalculatorSubmitResponse fromJson(Map<String, dynamic> json) => _$CalculatorSubmitResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CalculatorSubmitResponseToJson(this);
}