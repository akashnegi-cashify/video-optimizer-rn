import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../../src/app_builder/app_builder_groups/groups.dart';
import '../models/qc_action_comp_config.dart';
import '../widgets/qc_action_widget.dart';

part 'qc_action_component.g.dart';

@CshComponent(
    key: QcActionComponent.COMP_KEY, configModel: QcActionConfig, componentGroup: ComponentGroup.qcActionComponentKey)
class QcActionComponent extends StatelessComponent<QcActionConfig> {
  static const String COMP_KEY = "QC_qc_action_component";

  const QcActionComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return QCActionWidget(configData: configModel);
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return QcActionConfig.fromConfig;
  }
}
