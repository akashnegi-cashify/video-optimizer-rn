import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/dead_repair/models/device_dead_accept_reject_comp_params.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../l10n.dart';

part 'device_dead_accept_reject_screen.g.dart';

@CshPage(
    key: DeviceDeadAcceptRejectScreen.pageKey,
    pageGroup: PageGroup.qcDeviceDeadAcceptRejectPageKey,
    params: DeviceDeadAcceptRejectCompParamKeys.values)
class DeviceDeadAcceptRejectScreen extends BaseScreen<DeviceDeadAcceptRejectScreenArgs> {
  static const String pageKey = "QC_qc_device_dead_accept_reject";
  static const String route = "/qc-device-dead-accept-reject";

  const DeviceDeadAcceptRejectScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var l10n = L10n(context);
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: {
        DeviceDeadAcceptRejectCompParamKeys.header.value: args?.header ?? l10n.deadDevice,
        DeviceDeadAcceptRejectCompParamKeys.code.value: args?.code,
        DeviceDeadAcceptRejectCompParamKeys.selectedReason.value: args?.selectedReason,
        DeviceDeadAcceptRejectCompParamKeys.markId.value: args?.markId,
      },
    );
  }

  static Future navigateTo(
    BuildContext context, {
    String? header,
    String? selectedReason,
    String? code,
    int? markId,
  }) {
    return Navigator.pushNamed(
      context,
      route,
      arguments: DeviceDeadAcceptRejectScreenArgs(
        pageKey,
        header: header,
        selectedReason: selectedReason,
        code: code,
        markId: markId,
      ),
    );
  }
}

class DeviceDeadAcceptRejectScreenArgs extends BaseArguments {
  String? selectedReason;
  String? header;
  String? code;
  int? markId;

  DeviceDeadAcceptRejectScreenArgs(super.pageKey, {this.selectedReason, this.header, this.code, this.markId});
}
