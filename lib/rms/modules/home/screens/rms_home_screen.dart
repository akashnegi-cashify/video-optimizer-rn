import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/rms_groups.dart';

part 'rms_home_screen.g.dart';

@CshPage(key: RmsHomeScreen.pageKey, pageGroup: RmsPageGroup.rmsHomePageKey)
class RmsHomeScreen extends BaseScreen {
  static const String pageKey = "RMS_home_screen";
  static const String route = "rms/home";

  const RmsHomeScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
