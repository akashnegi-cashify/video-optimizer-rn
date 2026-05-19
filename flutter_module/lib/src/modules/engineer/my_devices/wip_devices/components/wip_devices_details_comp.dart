import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/providers/wip_device_detail_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../app_builder/app_builder_groups/groups.dart';
import '../models/wip_details_comp_param.dart';
import '../widgets/wip_detail_widget.dart';

part 'wip_devices_details_comp.g.dart';

@CshComponent(
    key: WipDeviceDetailsComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.wipDeviceComponentKey,
    params: WipDetailsCompParamKeys.values,
    paramModel: WipDetailsCompParam)
class WipDeviceDetailsComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_wip_devices_details_comp";

  const WipDeviceDetailsComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, NoneConfigModel? configModel) {
    return paramBuilder((param) {
      return ChangeNotifierProvider(
        create: (_) => WIPDeviceDetailProvider(param.deviceBarcode ?? ""),
        lazy: false,
        child: const WIPDetailWidget(),
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
