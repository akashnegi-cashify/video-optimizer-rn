import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'sub_order_group_listing_screen.g.dart';

@CshPage(key: SubOrderGroupListingScreen.pageKey, pageGroup: PageGroup.subOrderGroupListingKey)
class SubOrderGroupListingScreen extends BaseScreen {
  static const String pageKey = "sub_order_group_listing";
  static const String route = "/sub_order_group_listing_screen";

  const SubOrderGroupListingScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
