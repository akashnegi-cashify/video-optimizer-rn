import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'on_going_audit_screen.g.dart';

@CshPage(key: OnGoingAuditScreen.pageKey, pageGroup: QcPageGroup.qcOnGoingAuditPageKey)
class OnGoingAuditScreen extends BaseScreen {
  static const String pageKey = "QC_on_going_audit_screen";
  static const String route = "/ongoing_audit_screen";

  const OnGoingAuditScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}