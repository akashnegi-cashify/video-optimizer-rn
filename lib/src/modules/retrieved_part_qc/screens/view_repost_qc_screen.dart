import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../providers/qc_report_provider.dart';

part 'view_repost_qc_screen.g.dart';

@CshPage(key: ViewRepostQcScreen.pageKey, pageGroup: PageGroup.viewReportQcPageKey)
class ViewRepostQcScreen extends BaseScreen {
  static const String pageKey = "TRC_view_report_qc_screen";
  static const String route = "/view_report_qc_screen";

  const ViewRepostQcScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return PageWidget(
      pageKey: pageKey,
      setProviders: (BuildContext insideContext) => [
        ChangeNotifierProvider<QcRepostProvider>(
          create: (_) => QcRepostProvider(bodyData: {"from": null, "to": null}),
          lazy: false,
        )
      ],
    );
  }
}
