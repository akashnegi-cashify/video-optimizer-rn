import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class WarehouseAuditPerformParamModel {
  @ParamKey(key: WarehouseAuditPerformParamModelKeys.auditId)
  int? auditId;

  WarehouseAuditPerformParamModel({this.auditId});
}

enum WarehouseAuditPerformParamModelKeys with AbsParamKey {
  auditId("auditId");

  @override
  final String value;

  const WarehouseAuditPerformParamModelKeys(this.value);
}
