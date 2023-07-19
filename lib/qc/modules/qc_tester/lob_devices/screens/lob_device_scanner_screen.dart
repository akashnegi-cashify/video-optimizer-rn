import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'lob_device_scanner_screen.g.dart';

@CshPage(key: LobDeviceScannerScreen.pageKey, pageGroup: QcPageGroup.qcLobDeviceScannerPageKey)
class LobDeviceScannerScreen extends BaseScreen {
  static const String pageKey = "QC_lob_device_scanner_screen";
  static const String route = "/QC_lob_device_scanner_screen";

  const LobDeviceScannerScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}