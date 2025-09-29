import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

import '../../../app_builder/app_builder_groups/groups.dart';
import '../manage_parts/manage_parts_widget.dart';

part 'manage_parts_component.g.dart';

@CshComponent(
    key: ManagePartsComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.managePartsComponentKey)
class ManagePartsComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_manage_parts_comp";

  const ManagePartsComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, NoneConfigModel? configModel) {
    return const ManagePartsWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
