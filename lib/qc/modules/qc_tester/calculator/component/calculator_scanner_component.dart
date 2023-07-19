import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/widgets/calculator_scanner_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

part 'calculator_scanner_component.g.dart';

@CshComponent(
    key: CalculatorScannerComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: QcComponentGroup.qcCalculatorScannerComponentKey)
class CalculatorScannerComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_calculator_component";

  const CalculatorScannerComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const CalculatorScannerWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
