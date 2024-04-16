import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
part 'retrieved_part_qc_dashboard.g.dart';

@CshComponent(
    key: RetrievedPartQcDashboardComponent.COMP_KEY,
    componentGroup: ComponentGroup.retrievedPartQcDashboardComponentKey)
class RetrievedPartQcDashboardComponent extends StatelessComponent {
  static const String COMP_KEY = "QC_retrieved_part_qc_dashboard";

  const RetrievedPartQcDashboardComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const SizedBox.shrink();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return null;
  }
}
