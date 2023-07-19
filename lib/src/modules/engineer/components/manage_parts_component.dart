import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../app_builder/app_builder_groups/groups.dart';
import '../manage_parts/manage_parts_widget.dart';
import '../models/manage_parts_comp_config.dart';

part 'manage_parts_component.g.dart';

@CshComponent(
    key: ManagePartsComponent.COMP_KEY,
    configModel: ManagePartsCompConfig,
    componentGroup: ComponentGroup.managePartsComponentKey)
class ManagePartsComponent extends StatelessComponent<ManagePartsCompConfig> {
  static const String COMP_KEY = "TRC_manage_parts_comp";

  const ManagePartsComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, ManagePartsCompConfig? configModel) {
    return const ManagePartsWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return ManagePartsCompConfig.fromConfig;
  }
}
