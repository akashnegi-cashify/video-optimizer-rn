import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'dispatch_screen.g.dart';

@CshPage(key: DispatchScreen.pageKey, pageGroup: PageGroup.dispatchPageKey)
class DispatchScreen extends BaseScreen {
  static const String pageKey = "dispatch_screen";
  static const String route = "/dispatch_screen";

  const DispatchScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
