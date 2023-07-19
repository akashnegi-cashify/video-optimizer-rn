import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'device_scanner_screen.g.dart';

@CshPage(key: DeviceScannerScreen.pageKey, pageGroup: PageGroup.deviceScannerPageKey)
class DeviceScannerScreen extends BaseScreen {
  static const String pageKey = "TRC_device_scanner_screen";
  static const String route = "/device_scanner_screen";

  const DeviceScannerScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
