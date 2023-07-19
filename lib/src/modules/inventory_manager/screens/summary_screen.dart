import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../app_builder/app_builder_groups/groups.dart';

part 'summary_screen.g.dart';

@CshPage(key: SummaryScreen.pageKey, pageGroup: PageGroup.summaryPageKey)
class SummaryScreen extends BaseScreen {
  static const String pageKey = "TRC_summary_screen";
  static const String route = "/summary_screen";

  const SummaryScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
