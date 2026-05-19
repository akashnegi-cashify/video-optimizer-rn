import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'inventory_home_screen.g.dart';

@CshPage(key: InventoryHomeScreen.pageKey, pageGroup: PageGroup.inventoryHomePageKey)
class InventoryHomeScreen extends BaseScreen {
  static const String pageKey = "TRC_inventory_home_screen";
  static const String route = '/inventory_home_screen';

  const InventoryHomeScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
