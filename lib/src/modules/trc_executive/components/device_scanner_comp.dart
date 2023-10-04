import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

import '../widgets/device_scanner_widget.dart';

part 'device_scanner_comp.g.dart';

@CshComponent(
    key: DeviceScannerComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.deviceScannerComponentKey)
class DeviceScannerComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_device_scanner_widget";

  const DeviceScannerComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const DeviceScannerWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
