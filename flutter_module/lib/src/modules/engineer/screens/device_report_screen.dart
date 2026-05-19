import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/modules/engineer/models/device_report_comp_model.dart';

part 'device_report_screen.g.dart';

class DeviceReportScreenArg extends BaseArguments {
  final String deviceId;

  DeviceReportScreenArg(this.deviceId) : super(DeviceReportScreen.pageKey);

  Map<String, dynamic> toJson() {
    return {
      DeviceReportCompParamKeys.deviceId.value: deviceId,
    };
  }
}

@CshPage(
    key: DeviceReportScreen.pageKey,
    pageGroup: PageGroup.trcDeviceReportPageKey,
    params: DeviceReportCompParamKeys.values)
class DeviceReportScreen extends BaseScreen<DeviceReportScreenArg> {
  static const String pageKey = "TRC_device_report_screen";
  static const String route = "/trc_device_report_screen";

  const DeviceReportScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arg = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: arg?.toJson());
  }

  static Future navigate(BuildContext context, String deviceId) {
    return Navigator.of(context).pushNamed(route, arguments: DeviceReportScreenArg(deviceId));
  }
}
