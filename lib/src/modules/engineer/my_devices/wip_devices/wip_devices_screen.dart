import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../../models/engineer_device_info.dart';
import 'models/wip_details_comp_param.dart';

part 'wip_devices_screen.g.dart';

@CshPage(key: WipDevicesScreen.pageKey, params: WipDetailsCompParamKeys.values, pageGroup: PageGroup.wipDevicesPageKey)
class WipDevicesScreenArguments extends BaseArguments {
  final EngineerDeviceInfo? engineerDeviceInfo;

  WipDevicesScreenArguments({this.engineerDeviceInfo}) : super(WipDevicesScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[WipDetailsCompParamKeys.engineerDeviceInfo.value] = engineerDeviceInfo;
    return data;
  }
}

class WipDevicesScreen extends BaseScreen<WipDevicesScreenArguments> {
  static const String pageKey = "TRC_wip_devices";
  static const String route = "/wip_devices_screen";

  const WipDevicesScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
