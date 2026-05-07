import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'paint_shop_home_screen.g.dart';

@CshPage(key: PaintShopHomeScreen.pageKey, pageGroup: PageGroup.paintShopHomePageKey)
class PaintShopHomeScreen extends BaseScreen {
  static const String pageKey = "TRC_paint_shop_home_screen";
  static const String route = "/paint_shop_home_screen";

  const PaintShopHomeScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
