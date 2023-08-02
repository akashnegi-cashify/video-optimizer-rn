import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../models/assign_part_barcode_scanner_config.dart';
import '../models/assign_part_barcode_scanner_param.dart';
import '../screens/assign_part_barcode_scanner.dart';

part 'assign_part_barcode_scanner_component.g.dart';

@CshComponent(
    key: AssignPartBarcodeScannerComponent.COMP_KEY,
    configModel: AssignPartBarcodeScannerConfig,
    params: AssignPartBarcodeScannerParamKeys.values,
    paramModel: AssignPartBarcodeScannerParam,
    componentGroup: ComponentGroup.assignPartBarcodeScannerComponentKey)
class AssignPartBarcodeScannerComponent extends StatelessComponent<AssignPartBarcodeScannerConfig> {
  static const String COMP_KEY = "TRC_assign_part_barcode_scanner";

  const AssignPartBarcodeScannerComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((param) {
      return AssignBarcodeScannerCompWidget(
        args: param.arguments,
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return AssignPartBarcodeScannerConfig.fromConfig;
  }
}
