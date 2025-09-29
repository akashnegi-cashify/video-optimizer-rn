import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../l10n.dart';
import '../models/index.dart';

part 'reason_selection_screen.g.dart';

@CshPage(
  key: ReasonSelectionScreen.pageKey,
  pageGroup: PageGroup.qcReasonSelectionPageKey,
  params: ReasonSelectionCompParamKeys.values,
)
class ReasonSelectionScreen extends BaseScreen<ReasonSelectionScreenArgs> {
  static const String pageKey = "QC_qc_reason_selection";
  static const String route = "/qc-reason-selection";

  const ReasonSelectionScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var l10n = L10n(context);
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: {
        ReasonSelectionCompParamKeys.header.value: args?.header ?? l10n.deviceDeadRepair,
        ReasonSelectionCompParamKeys.reasonList.value: args?.reasonList,
        ReasonSelectionCompParamKeys.code.value: args?.code,
        ReasonSelectionCompParamKeys.roleType.value: args?.status,
        ReasonSelectionCompParamKeys.markId.value: args?.markId,
      },
    );
  }

  static Future navigateTo(
    BuildContext context, {
    String? header,
    int? status,
    List<String>? reasonList,
    String? code,
    int? markId,
  }) {
    return Navigator.pushReplacementNamed(context, route,
        arguments: ReasonSelectionScreenArgs(
          pageKey,
          header,
          status,
          reasonList,
          code,
          markId,
        ));
  }
}

class ReasonSelectionScreenArgs extends BaseArguments {
  List<String>? reasonList;
  int? status;
  String? header;
  String? code;
  int? markId;

  ReasonSelectionScreenArgs(
    super.pageKey,
    this.header,
    this.status,
    this.reasonList,
    this.code,
    this.markId,
  );
}
