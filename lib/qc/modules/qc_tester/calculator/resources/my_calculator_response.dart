import 'package:calculator/calculator.dart';
import 'package:calculator/src/resources/calculator_response.config.dart';
import 'package:calculator/src/resources/product_line.category.dart';
import 'package:calculator/src/resources/rule.response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_calculator_response.g.dart';

@JsonSerializable()
class MyCalculatorResponse extends CalculatorResponse {
  @JsonKey(name: "maq")
  List<ManualAuditQuestionItem>? manualAuditQuestions;

  MyCalculatorResponse(
      super.productName,
      super.brandId,
      super.calId,
      super.categories,
      super.configEPart,
      super.configPart,
      super.imageUrl,
      super.imeiKey,
      super.isExpressCity,
      super.isServiceAvailable,
      super.productId,
      super.productLineId,
      super.ruleExecutionMode,
      super.rules,
      super.selectionType,
      super.showPrice,
      super.userSelection,
      super.defaultRuleId);

  static MyCalculatorResponse fromJson(Map<String, dynamic> json) => _$MyCalculatorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyCalculatorResponseToJson(this);
}

@JsonSerializable()
class ManualAuditQuestionItem {
  @JsonKey(name: "mmid")
  int? manualMasterId;

  @JsonKey(name: "q")
  String? question;

  @JsonKey(includeToJson: false, includeFromJson: false)
  bool? isSelected;

  ManualAuditQuestionItem(this.manualMasterId, this.question);

  static ManualAuditQuestionItem fromJson(Map<String, dynamic> json) => _$ManualAuditQuestionItemFromJson(json);

  Map<String, dynamic> toJson() => _$ManualAuditQuestionItemToJson(this);
}
