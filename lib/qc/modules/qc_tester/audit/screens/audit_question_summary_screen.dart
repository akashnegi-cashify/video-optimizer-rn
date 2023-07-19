import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../models/audit_question_response.dart';
import '../models/audit_question_summary_comp_param.dart';

part 'audit_question_summary_screen.g.dart';

@CshPage(
    key: AuditQuestionSummaryScreen.pageKey,
    pageGroup: PageGroup.auditQuestionSummaryPageKey,
    params: AuditQuestionSummaryCompParamKeys.values)
class AuditQuestionSummaryArguments extends BaseArguments {
  final AuditQuestionResponse? questionDataModel;
  final String? scannedBarcode;

  AuditQuestionSummaryArguments({
    this.scannedBarcode,
    this.questionDataModel,
  }) : super(AuditQuestionSummaryScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[AuditQuestionSummaryCompParamKeys.scannedBarcode.value] = scannedBarcode;
    data[AuditQuestionSummaryCompParamKeys.questionDataModel.value] = questionDataModel;
    return data;
  }
}

class AuditQuestionSummaryScreen extends BaseScreen<AuditQuestionSummaryArguments> {
  static const String pageKey = "audit_question_summary";
  static const String route = "/audit-question-summary-screen";

  const AuditQuestionSummaryScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
