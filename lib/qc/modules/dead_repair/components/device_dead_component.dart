import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

import '../../../../src/app_builder/app_builder_groups/groups.dart';
import '../widgets/index.dart';

part 'device_dead_component.g.dart';

@CshComponent(
  key: DeviceDeadComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: ComponentGroup.DeviceDead,

)
class DeviceDeadComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_qc_device_dead_component";

  const DeviceDeadComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
      return DeadDeviceWidget()  ;
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
