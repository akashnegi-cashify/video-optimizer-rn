import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

import '../../../../src/app_builder/app_builder_groups/groups.dart';

part 'store_in_component.g.dart';

@CshComponent(
    key: StoreInComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.StoreIn)
class StoreInComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "store_in_component";

  const StoreInComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return Placeholder();

  }
  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
