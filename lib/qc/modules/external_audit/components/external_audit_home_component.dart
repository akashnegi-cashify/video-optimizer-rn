import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

part 'external_audit_home_component.g.dart';

@CshComponent(
    key: ExternalAuditHomeComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: QcComponentGroup.qcExternalAuditHomeComponentKey)
class ExternalAuditHomeComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_qc_external_audit_home_component";

  const ExternalAuditHomeComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return Center(
      child: Column(
        children: [
          CshBigButton(text: "Receive Stock", onPressed: () {
            // Navigator.pushNamed(context, "/qc_receive_stock_screen");
          }),
          CshBigButton(text: "Receive Return", onPressed: () {
            // Navigator.pushNamed(context, "/qc_receive_return_screen");
          }),
          CshBigButton(text: "Dispatch", onPressed: () {
            // Navigator.pushNamed(context, "/qc_dispatch_screen");
          }),
        ],
      ),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
