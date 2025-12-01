import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/device_scanner_screen_arguments_model.dart';

part 'device_scanner_screen.g.dart';

class DeviceScannerScreenArguments extends BaseArguments {
  String? storageBarcode;

  DeviceScannerScreenArguments(this.storageBarcode) : super(DeviceScannerScreen.pageKey);

  toMap() => {DeviceScannerScreenArgumentsModelParams.storageBarcode.value: storageBarcode};
}

@CshPage(
  key: DeviceScannerScreen.pageKey,
  pageGroup: PageGroup.deviceScannerPageKey,
  params: DeviceScannerScreenArgumentsModelParams.values,
)
class DeviceScannerScreen extends BaseScreen<DeviceScannerScreenArguments> {
  static const String pageKey = "TRC_device_scanner_screen";
  static const String route = "/device_scanner_screen";

  const DeviceScannerScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arguments = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: arguments?.toMap());
  }

  static pushNamed(BuildContext context, String storageBarcode) {
    Navigator.pushNamed(context, route, arguments: DeviceScannerScreenArguments(storageBarcode));
  }
}
