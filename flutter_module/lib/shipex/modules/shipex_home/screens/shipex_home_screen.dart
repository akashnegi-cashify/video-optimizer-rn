import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'shipex_home_screen.g.dart';

@CshPage(key: ShipexHomeScreen.pageKey, pageGroup: PageGroup.shipexHomePageKey)
class ShipexHomeScreen extends BaseScreen {
  static const String pageKey = "shipex_home_screen";
  static const String route = "/shioex_home_screen";

  const ShipexHomeScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
