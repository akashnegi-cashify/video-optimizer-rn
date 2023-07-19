import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../../../app_builder/app_builder_groups/groups.dart';
import '../models/my_devices_comp_config.dart';
import '../my_devices_widget.dart';

part 'my_devices_component.g.dart';

@CshComponent(
    key: MyDevicesComponent.COMP_KEY,
    configModel: MyDevicesCompConfig,
    componentGroup: ComponentGroup.myDevicesComponentKey)
class MyDevicesComponent extends StatelessComponent<MyDevicesCompConfig> {
  static const String COMP_KEY = "TRC_my_devices_comp";

  const MyDevicesComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, MyDevicesCompConfig? configModel) {
    return const MyDevicesWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return MyDevicesCompConfig.fromConfig;
  }
}
