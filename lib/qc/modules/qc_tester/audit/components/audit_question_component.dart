import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/resources/qc_common_config.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../models/audit_question_comp_param.dart';
import '../providers/audit_questions_provider.dart';
import '../widgets/audit_widget.dart';

part 'audit_question_component.g.dart';

@CshComponent(
    key: AuditQuestionComponent.COMP_KEY,
    componentGroup: ComponentGroup.auditQuestionComponentKey,
    params: AuditQuestionParamKeys.values,
    paramModel: AuditQuestionParam,
    configModel: QcCommonConfigModel)
class AuditQuestionComponent extends StatelessComponent<QcCommonConfigModel> {
  static const String COMP_KEY = "audit_question";

  const AuditQuestionComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, QcCommonConfigModel? configModel) {
    return paramBuilder((param) {
      return ChangeNotifierProvider<AuditQuestionsProvider>(
        create: (_) => AuditQuestionsProvider(param.scannedBarcode ?? ""),
        lazy: false,
        child: _AuditQuestions(scannedBarcode: param.scannedBarcode ?? ""),
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return QcCommonConfigModel.fromConfig;
  }
}

class _AuditQuestions extends StatelessWidget {
  final String scannedBarcode;

  _AuditQuestions({
    Key? key,
    required this.scannedBarcode,
  }) : super(key: key);

  final PageController controller = PageController(initialPage: 0, keepPage: false);

  @override
  Widget build(BuildContext context) {
    var provider = AuditQuestionsProvider.of(context);

    return (provider.isQuestionsDataLoading)
        ? const Center(
            child: SizedBox(
              height: Dimens.space_30,
              width: Dimens.space_30,
              child: CircularProgressIndicator(),
            ),
          )
        : AuditWidget(scanData: scannedBarcode);
  }
}
