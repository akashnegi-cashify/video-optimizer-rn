import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../../src/app_builder/app_builder_groups/qc_groups.dart';
import '../models/pixel_testing_param_model.dart';

part 'pixel_testing_screen.g.dart';

@CshPage(key: PixelTestingScreen.pageKey, pageGroup: QcPageGroup.qcPixelTestingPageKey)
class PixelTestingScreen extends BaseScreen<PixelTestingScreenArgs> {
  static const String pageKey = "QC_pixel_testing_screen";
  static const String route = "/pixel_testing_screen";

  const PixelTestingScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }

  static Future navigate(BuildContext context, String? deviceQrCode) {
    return Navigator.pushNamed(
      context,
      PixelTestingScreen.route,
      arguments: PixelTestingScreenArgs(deviceQrCode),
    );
  }
}

class PixelTestingScreenArgs extends BaseArguments {
  PixelTestingScreenArgs(this.deviceQrCode) : super(PixelTestingScreen.pageKey);

  final String? deviceQrCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[PixelTestingParamKeys.deviceQrCode.value] = deviceQrCode;
    return data;
  }
}
