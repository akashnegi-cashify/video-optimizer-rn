import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/common/model/device_barcode_param_model.dart';

part 'd2c_video_screen.g.dart';

class D2CVideoArguments extends BaseArguments {
  final String? barcode;

  D2CVideoArguments(this.barcode) : super(D2CVideoScreen.pageKey);

  Map<String, dynamic> toJson() {
    return {DeviceBarcodeParamKeys.deviceBarcode.value: barcode};
  }
}

@CshPage(key: D2CVideoScreen.pageKey, pageGroup: QcPageGroup.qcD2cVideoPageKey, params: DeviceBarcodeParamKeys.values)
class D2CVideoScreen extends BaseScreen<D2CVideoArguments> {
  static const String pageKey = "QC_d2c_video_page_key";
  static const String route = "/qc/d2c-video";

  const D2CVideoScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arg = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: arg?.toJson());
  }

  static navigate(BuildContext context, String? barcode) {
    Navigator.pushNamed(context, route, arguments: D2CVideoArguments(barcode));
  }
}
