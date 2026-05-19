import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'dismantle_home_screen.g.dart';

@CshPage(key: DismantleHomeScreen.pageKey, pageGroup: PageGroup.dismantleHomePageKey)
class DismantleHomeScreen extends BaseScreen {
  static const String pageKey = "TRC_dismantle_home_screen";
  static const String route = "/dismantle_home_screen";

  const DismantleHomeScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
