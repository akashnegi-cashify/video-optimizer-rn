import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class AuditQuestionParam {
  @ParamKey(key: AuditQuestionParamKeys.scannedBarcode)
  String? scannedBarcode;

  AuditQuestionParam({
    this.scannedBarcode,
  });
}

enum AuditQuestionParamKeys with AbsParamKey {
  scannedBarcode("sb");

  @override
  final String value;

  const AuditQuestionParamKeys(this.value);
}
