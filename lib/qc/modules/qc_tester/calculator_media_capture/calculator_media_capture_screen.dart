import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'calculator_media_capture_screen.g.dart';

@CshPage(key: CalculatorMediaCaptureScreen.pageKey, pageGroup: PageGroup.calculatorMediaCapturePageKey)
class CalculatorMediaCaptureScreen extends BaseScreen {
  static const String pageKey = "calculator_media_capture";
  static const String route = "/calculator_media_capture_screen";

  const CalculatorMediaCaptureScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
