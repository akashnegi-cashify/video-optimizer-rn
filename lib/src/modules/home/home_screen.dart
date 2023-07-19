import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../app_builder/app_builder_groups/groups.dart';

part 'home_screen.g.dart';

@CshPage(key: HomeScreen.pageKey, pageGroup: PageGroup.homePageKey)
class HomeScreen extends BaseScreen {
  static const String route = '/home';
  static const String pageKey = "TRC_home_screen";

  const HomeScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
