import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/qc/modules/external_audit/external_audit_perform_screen.dart';
import 'package:flutter_trc/qc/modules/external_audit/models/external_audit_enum.dart';

@CshPageParam()
class ExternalAuditPerformCompParam {
  @ParamKey(key: ExternalAuditPerformCompParamKeys.externalAuditType)
  ExternalAuditEnum auditType;

  ExternalAuditPerformCompParam({required this.auditType});
}

enum ExternalAuditPerformCompParamKeys with AbsParamKey {
  externalAuditType("auditType");

  @override
  final String value;

  const ExternalAuditPerformCompParamKeys(this.value);
}
