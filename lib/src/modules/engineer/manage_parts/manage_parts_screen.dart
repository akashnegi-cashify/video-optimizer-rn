import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'manage_parts_screen.g.dart';

@CshPage(key: ManagePartsScreen.pageKey, pageGroup: PageGroup.managePartsPageKey)
class ManagePartsScreen extends BaseScreen {
  static const String pageKey = "TRC_manage_parts_screen";
  static const String route = "/manage_parts_screen";

  const ManagePartsScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
