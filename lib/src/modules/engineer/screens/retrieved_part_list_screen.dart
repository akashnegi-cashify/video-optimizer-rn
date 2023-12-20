import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'retrieved_part_list_screen.g.dart';

@CshPage(key: RetrievedPartListScreen.pageKey, pageGroup: PageGroup.trcRetrievedPartListPageKey)
class RetrievedPartListScreen extends BaseScreen {
  static const String pageKey = "TRC_retrieved_part_list_screen";
  static const String route = "/trc_retrieved_part_list_screen";

  const RetrievedPartListScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
