import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/trc_executive_config_model.dart';

import '../../../app_builder/app_builder_groups/groups.dart';
import '../widgets/trc_executive_widget.dart';

part 'trc_executive_component.g.dart';

@CshComponent(
    key: TrcExecutiveComponent.COMP_KEY,
    configModel: TrcExecutiveConfigModel,
    componentGroup: ComponentGroup.TRCExecutiveComponentKey)
class TrcExecutiveComponent extends StatelessComponent<TrcExecutiveConfigModel> {
  static const String COMP_KEY = "TRC_trc_executive";

  const TrcExecutiveComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return TrcExecutiveWidget(configModel: configModel);
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return TrcExecutiveConfigModel.fromConfig;
  }
}
