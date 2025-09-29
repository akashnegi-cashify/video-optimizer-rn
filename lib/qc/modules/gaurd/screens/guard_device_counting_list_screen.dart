import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'guard_device_counting_list_screen.g.dart';

@CshPage(key: GuardDeviceCountingListScreen.pageKey, pageGroup: QcPageGroup.qcGuardDeviceCountingListPageKey)
class GuardDeviceCountingListScreen extends BaseScreen {
  static const String pageKey = "QC_guard_device_counting_list_screen";
  static const String route = "/qc_guard_device_counting_list_screen";

  const GuardDeviceCountingListScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
