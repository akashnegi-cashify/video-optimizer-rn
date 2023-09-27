import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

import '../widgets/engineer_home_widget.dart';

part 'engineer_home_component.g.dart';

@CshComponent(
    key: EngineerHomeComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.engineerHomeComponentKey)
class EngineerHomeComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_engineer_home";

  const EngineerHomeComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const EngineerHomeWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
