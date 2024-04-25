import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../widgets/view_report_parts_widget.dart';

part 'view_report_qc_component.g.dart';

@CshComponent(key: ViewReportQcComponent.COMP_KEY, componentGroup: ComponentGroup.viewReportQcComponentKey)
class ViewReportQcComponent extends StatelessComponent {
  static const String COMP_KEY = "TRC_view_report_qc";

  const ViewReportQcComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const ViewReportWidgetParts();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return null;
  }
}
