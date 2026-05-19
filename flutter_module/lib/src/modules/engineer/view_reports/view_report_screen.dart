import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../app_builder/app_builder_groups/groups.dart';

part 'view_report_screen.g.dart';

@CshPage(key: ViewReportScreen.pageKey, pageGroup: PageGroup.viewReportPageKey)
class ViewReportScreen extends BaseScreen {
  static const String pageKey = "TRC_view_report_screen";
  static const String route = "/view_report_screen";

  const ViewReportScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
