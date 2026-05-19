import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'splash_screen.g.dart';

@CshPage(key: SplashScreen.pageKey, pageGroup: PageGroup.splashPageKey)
class SplashScreen extends BaseScreen {
  static const String pageKey = "TRC_splash_screen";
  static const String route = "/splash_screen";

  const SplashScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
