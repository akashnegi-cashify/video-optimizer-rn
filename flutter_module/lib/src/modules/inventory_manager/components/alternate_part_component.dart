import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../models/alternate_part_comp_param.dart';
import '../screens/alternate_part_screen.dart';

part 'alternate_part_component.g.dart';

@CshComponent(
    key: AlternatePartComponent.COMP_KEY,
    configModel: NoneConfigModel,
    paramModel: AlternatePartCompParam,
    params: AlternatePartCompParamKeys.values,
    componentGroup: ComponentGroup.alternatePartComponentKey)
class AlternatePartComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_alternate_part_component";

  const AlternatePartComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((param) {
      return AlternatePartWidget(
        arg: param.arguments,
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
