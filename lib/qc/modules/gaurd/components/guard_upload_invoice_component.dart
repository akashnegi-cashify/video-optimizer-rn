import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/gaurd/providers/upload_invoice_provider.dart';
import 'package:flutter_trc/qc/modules/gaurd/widgets/guard_upload_invoice_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

part 'guard_upload_invoice_component.g.dart';

@CshComponent(
    key: GuardUploadInvoiceComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: QcComponentGroup.qcGuardUploadInvoiceComponentKey) // TODO: add params model here
class GuardUploadInvoiceComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_guard_upload_invoice_component";

  const GuardUploadInvoiceComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return ChangeNotifierProvider(create: (_) => UploadInvoiceProvider(), child: const GuardUploadInvoiceWidget());
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
