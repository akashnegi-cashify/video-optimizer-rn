import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'data_wipe_list_screen.g.dart';

@CshPage(key: DataWipeListScreen.pageKey, pageGroup: QcPageGroup.qcDataWipeListPageKey)
class DataWipeListScreen extends BaseScreen {
  static const String pageKey = "QC_data_wipe_list_screen";
  static const String route = "qc/data_wipe_list";

  const DataWipeListScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}