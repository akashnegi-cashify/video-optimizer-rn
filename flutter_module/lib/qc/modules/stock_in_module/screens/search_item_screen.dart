import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../../src/app_builder/app_builder_groups/qc_groups.dart';

part 'search_item_screen.g.dart';

@CshPage(
  key: SearchItemScreen.pageKey,
    pageGroup: QcPageGroup.qcSearchItemPageKey
)

class SearchItemScreen extends BaseScreen {
  static const String pageKey = "QC_qc_search_item";
  static const String route = "/search-item";

  const SearchItemScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
