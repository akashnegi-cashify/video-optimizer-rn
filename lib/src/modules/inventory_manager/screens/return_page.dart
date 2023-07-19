import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'return_page.g.dart';

@CshPage(key: ReturnScreen.pageKey, pageGroup: PageGroup.returnPageKey)
class ReturnScreen extends BaseScreen {
  static const String pageKey = "TRC_return_screen";
  static const String route = "/return_screen";

  const ReturnScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
