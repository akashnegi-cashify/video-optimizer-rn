import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/modules/engineer/view_reports/models/view_report_comp_config.dart';

import '../view_report_widget.dart';

part 'view_report_component.g.dart';

@CshComponent(
    key: ViewReportComponent.COMP_KEY,
    configModel: ViewReportCompConfig,
    componentGroup: ComponentGroup.viewReportComponentKey)
class ViewReportComponent extends StatelessComponent<ViewReportCompConfig> {
  static const String COMP_KEY = "TRC_view_report_comp";

  const ViewReportComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const ViewReportWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return ViewReportCompConfig.fromConfig;
  }
}
