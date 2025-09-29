import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../models/assigned_part_details_comp_param.dart';
import '../screens/assigned_part_details_screen.dart';

part 'assigned_part_details_component.g.dart';

@CshComponent(
    key: AssignedPartDetailsComponent.COMP_KEY,
    configModel: NoneConfigModel,
    params: AssignedPartDetailsCompParamKeys.values,
    paramModel: AssignedPartDetailsCompParam,
    componentGroup: ComponentGroup.assignedPartDetailsComponentKey)
class AssignedPartDetailsComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_assign_part_details_comp";

  const AssignedPartDetailsComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((param) {
      return AssignedPartDetailsCompWidget(
        arguments: param.arguments,
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
