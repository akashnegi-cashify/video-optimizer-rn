import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'trc_executive_lot_list_screen.g.dart';

@CshPage(key: TrcExecutiveLotListScreen.pageKey, pageGroup: PageGroup.trcExecutiveLotListPageKey)
class TrcExecutiveLotListScreen extends BaseScreen {
  static const String pageKey = "TRC_trc_executive_lot_list_screen";
  static const String route = "/trc_executive_lot_list_screen";

  const TrcExecutiveLotListScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
