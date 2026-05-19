import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../models/audit_question_comp_param.dart';

part 'audit_question_screen.g.dart';

@CshPage(
    key: AuditQuestionsScreen.pageKey, pageGroup: PageGroup.auditQuestionPageKey, params: AuditQuestionParamKeys.values)
class AuditQuestionsScreenArguments extends BaseArguments {
  final String? scannedBarcode;

  AuditQuestionsScreenArguments({
    this.scannedBarcode,
  }) : super(AuditQuestionsScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[AuditQuestionParamKeys.scannedBarcode.value] = scannedBarcode;
    return data;
  }
}

class AuditQuestionsScreen extends BaseScreen<AuditQuestionsScreenArguments> {
  static const String pageKey = "audit_questions";
  static String route = "/audit_questions_screen";

  const AuditQuestionsScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
