import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'rider_home_screen.g.dart';

@CshPage(key: RiderHomeScreen.pageKey, pageGroup: PageGroup.riderHomePageKey)
class RiderHomeScreen extends BaseScreen {
  static const String pageKey = "TRC_rider_home";
  static const String route = "/rider_home_screen";

  const RiderHomeScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
