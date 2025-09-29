import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'qc_action_screen.g.dart';

@CshPage(key: QcActionScreen.pageKey, pageGroup: PageGroup.qcActionPageKey)
class QcActionScreen extends BaseScreen {
  static const String pageKey = "QC_qc_action_screen";
  static const String route = "/qc_action_screen";

  const QcActionScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
