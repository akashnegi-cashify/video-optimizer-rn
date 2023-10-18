import 'package:builder_project/builder_project.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/gaurd/models/add_agent_comp_param.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

import '../l10n.dart';

part 'qc_guard_add_agent_screen.g.dart';

@CshPage(
  key: QcGuardAddAgentScreen.pageKey,
  pageGroup: QcPageGroup.qcGuardAddAgentPageKey,
  params: AddAgentCompParamKeys.values,
)
class QcGuardAddAgentScreen extends BaseScreen<QcGuardAddAgentScreenArgs> {
  static const String pageKey = "QC_guard_add_agent_screen";
  static const String route = "/qc_guard_add_agent_screen";

  const QcGuardAddAgentScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var l10n = L10n(context);
    var args = getArguments(context);

    if(ArrayUtil.isNullOrEmpty(args?.agentList)){
      return Center(child: CshTextNew.h3(l10n.agentListMustNotBeNullOrEmpty),);
    }

    return PageWidget(
      pageKey: pageKey,
      initialValue: {
        AddAgentCompParamKeys.header.value: l10n.roleGuard,
        AddAgentCompParamKeys.agentList.value: ArrayUtil.removeNullItems<String>(args?.agentList ?? []),
      },
    );
  }

  static navigate(BuildContext context, List<String>? agentList) {
    Navigator.pushNamed(
      context,
      QcGuardAddAgentScreen.route,
      arguments: QcGuardAddAgentScreenArgs(
        QcGuardAddAgentScreen.pageKey,
        agentList: agentList,
      ),
    );
  }
}

class QcGuardAddAgentScreenArgs extends BaseArguments {
  final List<String>? agentList;
  QcGuardAddAgentScreenArgs(super.pageKey, {required this.agentList});
}
