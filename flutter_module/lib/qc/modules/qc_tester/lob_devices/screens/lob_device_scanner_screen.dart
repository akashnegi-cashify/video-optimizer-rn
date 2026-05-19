import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/common/model/device_barcode_param_model.dart';

part 'lob_device_scanner_screen.g.dart';

class LobDeviceScannerScreenArg extends BaseArguments {
  final String? barcode;

  LobDeviceScannerScreenArg({this.barcode}) : super(LobDeviceScannerScreen.pageKey);

  Map<String, dynamic> toJson() => {DeviceBarcodeParamKeys.deviceBarcode.value: barcode};
}

@CshPage(
  key: LobDeviceScannerScreen.pageKey,
  pageGroup: QcPageGroup.qcLobDeviceScannerPageKey,
  params: DeviceBarcodeParamKeys.values,
)
class LobDeviceScannerScreen extends BaseScreen<LobDeviceScannerScreenArg> {
  static const String pageKey = "QC_lob_device_scanner_screen";
  static const String route = "/QC_lob_device_scanner_screen";

  const LobDeviceScannerScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arg = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: arg?.toJson());
  }
}
