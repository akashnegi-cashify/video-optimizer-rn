import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../../../../src/app_builder/app_headers/qc_general_header/models/qc_general_header_param.dart';
import '../l10n.dart';

part 'device_dead_repair_screen.g.dart';

@CshPage(
  key: DeviceDeadRepairScreen.pageKey,
  pageGroup: PageGroup.qcDeviceDeadRepairPageKey,
)
class DeviceDeadRepairScreen extends BaseScreen<DeviceDeadRepairScreenArgs> {
  static const String pageKey = "QC_qc_device_dead_repair";
  static const String route = "/qc-device-dead-repair";

  const DeviceDeadRepairScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var l10n = L10n(context);
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: {QcGeneralHeaderParamKeys.header.value: l10n.deviceDeadRepair},
    );
  }

  static Future navigateTo(BuildContext context) {
    return Navigator.pushNamed(context, route, arguments: DeviceDeadRepairScreenArgs(pageKey));
  }
}

class DeviceDeadRepairScreenArgs extends BaseArguments {
  DeviceDeadRepairScreenArgs(super.pageKey);
}
