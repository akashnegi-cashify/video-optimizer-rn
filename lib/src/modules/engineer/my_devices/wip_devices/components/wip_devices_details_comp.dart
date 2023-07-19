import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../app_builder/app_builder_groups/groups.dart';
import '../models/wip_details_comp_config.dart';
import '../models/wip_details_comp_param.dart';
import '../widgets/wip_detail_widget.dart';

part 'wip_devices_details_comp.g.dart';

@CshComponent(
    key: WipDeviceDetailsComponent.COMP_KEY,
    configModel: WIPDetailsCompConfig,
    componentGroup: ComponentGroup.wipDeviceComponentKey,
    params: WipDetailsCompParamKeys.values,
    paramModel: WipDetailsCompParam)
class WipDeviceDetailsComponent extends StatelessComponent<WIPDetailsCompConfig> {
  static const String COMP_KEY = "TRC_wip_devices_details_comp";

  const WipDeviceDetailsComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, WIPDetailsCompConfig? configModel) {
    return paramBuilder((param) {
      return WIPDetailWidget(
        deviceInfo: param.engineerDeviceInfo,
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return WIPDetailsCompConfig.fromConfig;
  }
}
