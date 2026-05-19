import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/modules/engineer/models/device_report_comp_model.dart';
import 'package:flutter_trc/src/modules/engineer/providers/device_report_provider.dart';
import 'package:flutter_trc/src/modules/engineer/widgets/device_report_widget.dart';
import 'package:provider/provider.dart';

import '../../../app_builder/app_builder_groups/groups.dart';

part 'device_report_component.g.dart';

@CshComponent(
    key: DeviceReportComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.trcDeviceReportComponentKey,
    paramModel: DeviceReportCompParam,
    params: DeviceReportCompParamKeys.values)
class DeviceReportComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_device_report_component";

  const DeviceReportComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((model) => ChangeNotifierProvider(
          create: (context) => DeviceReportProvider(model.deviceId),
          child: const DeviceReportWidget(),
        ));
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
