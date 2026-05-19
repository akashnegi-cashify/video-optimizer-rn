import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/external_audit/models/external_audit_perform_comp_params.dart';
import 'package:flutter_trc/qc/modules/external_audit/providers/external_audit_perform_provider.dart';
import 'package:flutter_trc/qc/modules/external_audit/widgets/external_audit_perform_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

part 'external_audit_perform_component.g.dart';

@CshComponent(
    key: ExternalAuditPerformComponent.COMP_KEY,
    configModel: NoneConfigModel,
    paramModel: ExternalAuditPerformCompParam,
    params: ExternalAuditPerformCompParamKeys.values,
    componentGroup: QcComponentGroup.qcExternalAuditPerformComponentKey)
class ExternalAuditPerformComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_qc_external_audit_perform_component";

  const ExternalAuditPerformComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((model) => ChangeNotifierProvider(
          create: (_) => ExternalAuditPerformProvider(model.auditType),
          child: const ExternalAuditPerformWidget(),
        ));
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
