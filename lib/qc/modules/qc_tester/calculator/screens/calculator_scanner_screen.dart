import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'calculator_scanner_screen.g.dart';

@CshPage(key: CalculatorScannerScreen.pageKey, pageGroup: QcPageGroup.qcCalculatorScannerPageKey)
class CalculatorScannerScreen extends BaseScreen {
  static const String pageKey = "QC_calculator_scanner_screen";
  static const String route = "/calculator_scanner";

  const CalculatorScannerScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}