import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/barcode_scanner_module/providers/barcode_scanner_provider.dart';
import 'package:flutter_trc/qc/resources/qc_common_config.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../widgets/barcode_scanner_widget.dart';

part 'barcode_scanner_component.g.dart';

@CshComponent(
    key: BarcodeScannerComponent.COMP_KEY,
    configModel: QcCommonConfigModel,
    componentGroup: ComponentGroup.barcodeScannerComponentKey)
class BarcodeScannerComponent extends StatelessComponent<QcCommonConfigModel> {
  static const String COMP_KEY = "barcode_scanner_component";

  const BarcodeScannerComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, QcCommonConfigModel? configModel) {
    return ChangeNotifierProvider<BarcodeScannerProvider>(
      create: (_) => BarcodeScannerProvider(),
      lazy: false,
      child: const BarcodeScannerWidget(),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return QcCommonConfigModel.fromConfig;
  }
}
