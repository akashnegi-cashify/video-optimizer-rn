import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

import '../widgets/shipex_dispatch_widget.dart';

part 'dispatch_component.g.dart';

@CshComponent(
    key: DispatchComponent.COMP_KEY, componentGroup: ComponentGroup.dispatchComponentKey, configModel: NoneConfigModel)
class DispatchComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "dispatch_component";

  const DispatchComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, NoneConfigModel? configModel) {
    return ShipexDispatchWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
