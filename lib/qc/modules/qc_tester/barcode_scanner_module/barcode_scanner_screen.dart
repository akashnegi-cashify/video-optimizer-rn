import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'barcode_scanner_screen.g.dart';

@Deprecated("No Longer used")
@CshPage(key: BarcodeScannerScreen.pageKey, pageGroup: PageGroup.barcodeScannerPageKey)
class BarcodeScannerScreen extends BaseScreen {
  static const String pageKey = "barcode_scanner";
  static const String route = "/barcode-scan";

  const BarcodeScannerScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
