import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/home/models/qc_tester_home_config_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/home/widgets/qc_tester_home_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'qc_tester_home_component.g.dart';

@CshComponent(
    key: QcTesterHomeComponent.COMP_KEY,
    configModel: QcTesterHomeConfigModel,
    componentGroup: QcComponentGroup.qcTesterHomeComponentKey)
class QcTesterHomeComponent extends StatelessComponent<QcTesterHomeConfigModel> {
  static const String COMP_KEY = "QC_qc_tester_home";

  const QcTesterHomeComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const QcTesterHomeWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return QcTesterHomeConfigModel.fromConfig;
  }
}
