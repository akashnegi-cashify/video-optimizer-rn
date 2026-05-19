import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/external_audit/external_audit_perform_screen.dart';
import 'package:flutter_trc/qc/modules/external_audit/models/external_audit_enum.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

import '../l10n.dart';

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
    var l10n = L10n(context);
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Dimens.space_32),
          CshBigButton(
            text: l10n.receiveStock,
            onPressed: () => _navigateToExternalAuditPerformScreen(context, ExternalAuditEnum.receiveStock),
          ),
          const SizedBox(height: Dimens.space_16),
          CshBigButton(
            text: l10n.receiveReturn,
            onPressed: () => _navigateToExternalAuditPerformScreen(context, ExternalAuditEnum.receiveReturn),
          ),
          const SizedBox(height: Dimens.space_16),
          CshBigButton(
            text: l10n.dispatch,
            onPressed: () => _navigateToExternalAuditPerformScreen(context, ExternalAuditEnum.dispatch),
          ),
        ],
      ),
    );
  }

  _navigateToExternalAuditPerformScreen(BuildContext context, ExternalAuditEnum auditType) {
    Navigator.pushNamed(context, ExternalAuditPerformScreen.route,
        arguments: ExternalAuditPerformScreenArguments(auditType));
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
