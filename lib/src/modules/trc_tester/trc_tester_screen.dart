import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'trc_tester_screen.g.dart';

@CshPage(key: TrcTesterScreen.pageKey, pageGroup: PageGroup.trcTesterPageKey)
class TrcTesterScreen extends BaseScreen {
  static const String pageKey = "TRC_trc_tester";
  static const String route = "/trc_tester";

  const TrcTesterScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}