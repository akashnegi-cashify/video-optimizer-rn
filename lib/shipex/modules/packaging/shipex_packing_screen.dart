import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'shipex_packing_screen.g.dart';

@CshPage(key: ShipexPackingScreen.pageKey, pageGroup: PageGroup.shipexPackingPageKey)
class ShipexPackingScreen extends BaseScreen {
  static const String pageKey = "shipex_packing_screen";
  static const String route = "/shipex_packing_screen";

  const ShipexPackingScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
