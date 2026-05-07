import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'body_shop_home_screen.g.dart';

@CshPage(key: BodyShopHomeScreen.pageKey, pageGroup: PageGroup.bodyShopHomePageKey)
class BodyShopHomeScreen extends BaseScreen {
  static const String pageKey = "TRC_body_shop_home_screen";
  static const String route = "/body_shop_home_screen";

  const BodyShopHomeScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
