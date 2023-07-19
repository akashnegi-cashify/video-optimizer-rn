import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'pq_home_screen.g.dart';

@CshPage(key: PartQCHomeScreen.pageKey, pageGroup: PageGroup.partQcHomePageKey)
class PartQCHomeScreen extends BaseScreen {
  static const String pageKey = "TRC_part_qc_home";
  static const String route = "/part_qc_home_screen";

  const PartQCHomeScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
