import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/widgets/on_going_audit_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

part 'on_going_audit_component.g.dart';

@CshComponent(
    key: OnGoingAuditComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: QcComponentGroup.qcOnGoingAuditComponentKey)
class OnGoingAuditComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_on_going_audit_component";

  const OnGoingAuditComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const OnGoingAuditWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
