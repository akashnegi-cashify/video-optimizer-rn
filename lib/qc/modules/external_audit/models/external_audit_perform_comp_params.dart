import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/qc/modules/external_audit/external_audit_perform_screen.dart';

@CshPageParam()
class ExternalAuditPerformCompParam {
  @ParamKey(key: ExternalAuditPerformCompParamKeys.externalAuditPerformArg)
  ExternalAuditPerformScreenArguments? args;

  ExternalAuditPerformCompParam({this.args});
}

enum ExternalAuditPerformCompParamKeys with AbsParamKey {
  externalAuditPerformArg("args");

  @override
  final String value;

  const ExternalAuditPerformCompParamKeys(this.value);
}
