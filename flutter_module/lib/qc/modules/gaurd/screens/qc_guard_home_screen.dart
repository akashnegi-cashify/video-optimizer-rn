import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'qc_guard_home_screen.g.dart';

@CshPage(key: QcGuardHomeScreen.pageKey, pageGroup: QcPageGroup.qcGuardHomePageKey)
class QcGuardHomeScreen extends BaseScreen {
  static const String pageKey = "QC_guard_home_screen";
  static const String route = "/qc_guard_home_screen";

  const QcGuardHomeScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}