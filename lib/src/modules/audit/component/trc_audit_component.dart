import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/screens/audit_question_screen.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';

part 'trc_audit_component.g.dart';

@CshComponent(
    key: TrcAuditComponent.COMP_KEY, configModel: NoneConfigModel, componentGroup: ComponentGroup.trcAuditComponentKey)
class TrcAuditComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_audit_home_component";

  const TrcAuditComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CshBigButton(
          text: "Audit",
          onPressed: () {
            CshMlScannerUtil().openScanner(
              context,
              onScanned: (scannedData, controller) {
                AuditQuestionsScreenArguments args = AuditQuestionsScreenArguments(scannedBarcode: scannedData.trim());
                Navigator.of(context).pushReplacementNamed(AuditQuestionsScreen.route, arguments: args);
              },
            );
          },
        )
      ],
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
