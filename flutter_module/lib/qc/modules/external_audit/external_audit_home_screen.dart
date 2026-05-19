import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'external_audit_home_screen.g.dart';

@CshPage(key: ExternalAuditHomeScreen.pageKey, pageGroup: QcPageGroup.qcExternalAuditHomePageKey)
class ExternalAuditHomeScreen extends BaseScreen {
  static const String pageKey = "QC_qc_external_audit_home_screen";
  static const String route = "/qc_external_audit_home_screen";

  const ExternalAuditHomeScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}