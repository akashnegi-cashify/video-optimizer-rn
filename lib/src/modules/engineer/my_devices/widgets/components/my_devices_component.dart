import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

import '../../../../../app_builder/app_builder_groups/groups.dart';
import '../my_devices_widget.dart';

part 'my_devices_component.g.dart';

@CshComponent(
    key: MyDevicesComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.myDevicesComponentKey)
class MyDevicesComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_my_devices_comp";

  const MyDevicesComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, NoneConfigModel? configModel) {
    return const MyDevicesWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
