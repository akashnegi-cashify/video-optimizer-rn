import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/modules/part_qc/retrieved_part_qc/providers/part_qc_user_report_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/view_report_parts_widget.dart';

part 'view_report_qc_component.g.dart';

@CshComponent(key: ViewReportQcComponent.COMP_KEY, componentGroup: ComponentGroup.viewReportQcComponentKey)
class ViewReportQcComponent extends StatelessComponent {
  static const String COMP_KEY = "TRC_view_report_qc";

  const ViewReportQcComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return ChangeNotifierProvider(
      create: (_) => PartQcUserReportProvider(),
      lazy: false,
      child: const ViewReportWidgetParts(),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return null;
  }
}
