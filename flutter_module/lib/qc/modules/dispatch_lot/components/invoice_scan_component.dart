import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../../src/app_builder/app_builder_groups/qc_groups.dart';
import '../../../../src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import '../widgets/index.dart';

part 'invoice_scan_component.g.dart';

@CshComponent(
  key: InvoiceScanComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: QcComponentGroup.qcInvoiceScanComponentKey,
)
class InvoiceScanComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_qc_invoice_scan_component";

  const InvoiceScanComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const InvoiceScanWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
