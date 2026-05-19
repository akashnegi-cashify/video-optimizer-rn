import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'l4_home_screen.g.dart';

@CshPage(key: L4HomeScreen.pageKey, pageGroup: PageGroup.l4PageKey)
class L4HomeScreen extends BaseScreen {
  static const String pageKey = "TRC_l4_home_screen";
  static const String route = "/l4_home_screen";

  const L4HomeScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
