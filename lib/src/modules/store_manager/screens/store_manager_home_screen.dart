import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'store_manager_home_screen.g.dart';

@CshPage(key: StoreManagerHomeScreen.pageKey, pageGroup: PageGroup.trcStoreManagerHomePageKey)
class StoreManagerHomeScreen extends BaseScreen {
  static const String pageKey = "TRC_store_manager_home";
  static const String route = "/trc_store_manager_home_screen";

  const StoreManagerHomeScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
