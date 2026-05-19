import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'calculation_screen.g.dart';

@CshPage(key: CalculationScreen.pageKey, pageGroup: PageGroup.calculatorPageKey)
class CalculationScreen extends BaseScreen {
  static const String pageKey = "calculation_screen";
  static const String route = "/calculator-screen";

  const CalculationScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}