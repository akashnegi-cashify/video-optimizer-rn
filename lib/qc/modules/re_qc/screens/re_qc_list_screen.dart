import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 're_qc_list_screen.g.dart';

@CshPage(key: ReQcListScreen.pageKey, pageGroup: QcPageGroup.qcReQcListPageKey)
class ReQcListScreen extends BaseScreen {
  static const String pageKey = "QC_re_qc_list_screen";
  static const String route = "/qc_re_qc_list_screen";

  const ReQcListScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
