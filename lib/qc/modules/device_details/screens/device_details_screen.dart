import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/common/model/device_barcode_param_model.dart';

part 'device_details_screen.g.dart';

class DeviceDetailScreenArg extends BaseArguments {
  final String deviceBarcode;

  DeviceDetailScreenArg(this.deviceBarcode) : super(DeviceDetailsScreen.pageKey);

  Map<String, dynamic> toJson() => {DeviceBarcodeParamKeys.deviceBarcode.value: deviceBarcode};
}

@CshPage(
    key: DeviceDetailsScreen.pageKey,
    pageGroup: QcPageGroup.qcDeviceDetailsPageKey,
    params: DeviceBarcodeParamKeys.values)
class DeviceDetailsScreen extends BaseScreen<DeviceDetailScreenArg> {
  static const String pageKey = "QC_device_details_screen";
  static const String route = "/device_details_screen";

  const DeviceDetailsScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arg = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: arg?.toJson());
  }

  static pushNamed(BuildContext context, String deviceBarcode) {
    Navigator.pushNamed(context, route, arguments: DeviceDetailScreenArg(deviceBarcode));
  }
}
