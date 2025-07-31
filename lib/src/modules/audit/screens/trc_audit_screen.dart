import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'trc_audit_screen.g.dart';

@CshPage(key: TrcAuditScreen.pageKey, pageGroup: PageGroup.trcAuditPageKey)
class TrcAuditScreen extends BaseScreen {
  static const String pageKey = "TRC_audit_home_screen";
  static const String route = "/trc-audit";

  const TrcAuditScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
