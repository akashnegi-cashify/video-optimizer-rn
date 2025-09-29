import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

import '../widget/l4_widget.dart';

part 'l4_component.g.dart';

@CshComponent(
  key: L4Component.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: ComponentGroup.l4ComponentKey,
)
class L4Component extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_l4_comp";

  const L4Component(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const L4HomeWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
