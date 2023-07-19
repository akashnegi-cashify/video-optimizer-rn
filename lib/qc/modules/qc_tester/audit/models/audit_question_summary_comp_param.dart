import 'package:csh_annotation/annotation.dart';

import 'audit_question_response.dart';

@CshPageParam()
class AuditQuestionSummaryCompParam {
  @ParamKey(key: AuditQuestionSummaryCompParamKeys.questionDataModel)
  AuditQuestionResponse? questionDataModel;
  @ParamKey(key: AuditQuestionSummaryCompParamKeys.scannedBarcode)
  String? scannedBarcode;

  AuditQuestionSummaryCompParam({
    this.questionDataModel,
    this.scannedBarcode,
  });
}

enum AuditQuestionSummaryCompParamKeys with AbsParamKey {
  questionDataModel("qdm"),
  scannedBarcode("sb");

  @override
  final String value;

  const AuditQuestionSummaryCompParamKeys(this.value);
}
