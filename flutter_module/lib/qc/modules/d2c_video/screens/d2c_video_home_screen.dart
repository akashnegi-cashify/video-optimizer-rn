import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'd2c_video_home_screen.g.dart';

@CshPage(key: D2cVideoHomeScreen.pageKey, pageGroup: QcPageGroup.qcD2cVideoHomePageKey)
class D2cVideoHomeScreen extends BaseScreen {
  static const String pageKey = "QC_d2c_video_home_screen";
  static const String route = "/d2c_video_home";

  const D2cVideoHomeScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}