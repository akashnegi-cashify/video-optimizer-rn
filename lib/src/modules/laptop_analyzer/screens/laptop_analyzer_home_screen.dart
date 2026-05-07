import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'laptop_analyzer_home_screen.g.dart';

@CshPage(key: LaptopAnalyzerHomeScreen.pageKey, pageGroup: PageGroup.laptopAnalyzerHomePageKey)
class LaptopAnalyzerHomeScreen extends BaseScreen {
  static const String pageKey = "TRC_laptop_analyzer_home_screen";
  static const String route = "/laptop_analyzer_home_screen";

  const LaptopAnalyzerHomeScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
