import 'package:builder_component/builder_component.dart';
import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/external_audit/models/external_audit_enum.dart';
import 'package:flutter_trc/qc/modules/external_audit/models/external_audit_perform_comp_params.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:provider/provider.dart';

part 'external_audit_perform_screen.g.dart';

class ExternalAuditPerformScreenArguments extends BaseArguments {
  ExternalAuditEnum externalAuditEnum;

  ExternalAuditPerformScreenArguments(this.externalAuditEnum) : super(ExternalAuditPerformScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[ExternalAuditPerformCompParamKeys.externalAuditType.value] = externalAuditEnum;
    return data;
  }
}

@CshPage(
    key: ExternalAuditPerformScreen.pageKey,
    pageGroup: QcPageGroup.qcExternalAuditPerformPageKey,
    params: ExternalAuditPerformCompParamKeys.values)
class ExternalAuditPerformScreen extends BaseScreen<ExternalAuditPerformScreenArguments> {
  static const String pageKey = "QC_qc_external_audit_perform_screen";
  static const String route = "/qc_external_audit_perform_screen";

  const ExternalAuditPerformScreen({super.key});

  @override
  Widget build(BuildContext context) {

    DBSyncProvider dbProvider = DBSyncProvider.of(context);
    if (dbProvider.syncingDB) {
      return dbProvider.syncWidget;
    }

    return Selector<GlobalParamProvider, String?>(
      builder: (_, value, Widget? child) {
        return buildView(context);
      },
      selector: (BuildContext context, GlobalParamProvider provider) => provider.data[GlobalParams.ssoToken.value],
    );
  }

  @override
  Widget buildView(BuildContext context) {
    ExternalAuditPerformScreenArguments? arg = getArguments(context);

    return PageWidget(
      pageKey: pageKey,
      initialValue: arg?.toJson(),
    );
  }
}
