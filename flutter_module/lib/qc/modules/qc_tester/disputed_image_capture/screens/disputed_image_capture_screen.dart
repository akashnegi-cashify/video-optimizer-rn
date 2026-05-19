import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../models/disputed_image_capture_param.dart';

part 'disputed_image_capture_screen.g.dart';

@CshPage(
    key: DisputedImageCaptureScreen.pageKey,
    pageGroup: PageGroup.disputedImageCapturePageKey,
    params: DisputedImageCaptureScreenParamKeys.values)
class DisputedImageCaptureScreenArguments extends BaseArguments {
  final String? barcode;

  DisputedImageCaptureScreenArguments({
    this.barcode,
  }) : super(DisputedImageCaptureScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[DisputedImageCaptureScreenParamKeys.barcode.value] = barcode;
    return data;
  }
}

class DisputedImageCaptureScreen extends BaseScreen<DisputedImageCaptureScreenArguments> {
  static const String pageKey = "disputed_image_capture_screen";
  static const String route = "/disputed_image_capture_screen";

  const DisputedImageCaptureScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
