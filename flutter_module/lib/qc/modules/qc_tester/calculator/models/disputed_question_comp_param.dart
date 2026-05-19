import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';



@CshPageParam()
class DisputedQuestionParam {
  @ParamKey(key: DisputedQuestionParamKeys.disputedQuestionList)
  List<ManualAuditQuestionItem>? disputedQuestionList;

  DisputedQuestionParam({
    this.disputedQuestionList,
  });
}

enum DisputedQuestionParamKeys with AbsParamKey {
  disputedQuestionList("dql");

  @override
  final String value;

  const DisputedQuestionParamKeys(this.value);
}
