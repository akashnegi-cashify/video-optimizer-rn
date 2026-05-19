import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/models/warehouse_audit_perform_param_model.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'warehouse_audit_perform_screen.g.dart';

class WarehouseAuditPerformScreenArg extends BaseArguments {
  final int auditId;

  WarehouseAuditPerformScreenArg(this.auditId) : super(WarehouseAuditPerformScreen.pageKey);

  Map<String, dynamic> toJson() => {WarehouseAuditPerformParamModelKeys.auditId.value: auditId};
}

@CshPage(
  key: WarehouseAuditPerformScreen.pageKey,
  pageGroup: QcPageGroup.qcWarehouseAuditPerformPageKey,
  params: WarehouseAuditPerformParamModelKeys.values,
)
class WarehouseAuditPerformScreen extends BaseScreen<WarehouseAuditPerformScreenArg> {
  static const String pageKey = "QC_warehouse_audit_perform_screen";
  static const String route = "/warehouse_audit_perform_screen";

  const WarehouseAuditPerformScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arg = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: arg?.toJson());
  }

  static pushNamed(BuildContext context, int auditId) {
    Navigator.pushNamed(context, route, arguments: WarehouseAuditPerformScreenArg(auditId));
  }
}
