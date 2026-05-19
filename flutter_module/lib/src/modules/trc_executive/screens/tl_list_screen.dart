import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'tl_list_screen.g.dart';

@CshPage(key: TlListScreen.pageKey, pageGroup: PageGroup.trcTlListPageKey)
class TlListScreen extends BaseScreen {
  static const String pageKey = "TRC_tl_list_screen";
  static const String route = "/tl_list_screen";

  const TlListScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
