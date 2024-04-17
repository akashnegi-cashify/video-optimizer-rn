import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../providers/qc_report_provider.dart';

part 'retrieved_parts_qc_dashboard_screen.g.dart';

@CshPage(key: RetrievedPartsQcDashboardScreen.pageKey, pageGroup: PageGroup.retrievedPartQcDashboardPageKey)
class RetrievedPartsQcDashboardScreen extends BaseScreen {
  static const String pageKey = "TRC_retrieved_parts_qc_dashboard_page";
  static const String route = "/retrieved_parts_qc_dashboard_page";

  const RetrievedPartsQcDashboardScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return PageWidget(
      pageKey: pageKey,
      setProviders: (BuildContext insideContext) => [
        ChangeNotifierProvider<QcRepostProvider>(
          create: (_) => QcRepostProvider(),
          lazy: false,
        )
      ],
    );
  }
}
