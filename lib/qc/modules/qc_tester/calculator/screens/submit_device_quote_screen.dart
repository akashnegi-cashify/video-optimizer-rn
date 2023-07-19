import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'submit_device_quote_screen.g.dart';

@CshPage(key: SubmitDeviceQuoteScreen.pageKey, pageGroup: QcPageGroup.qcSubmitDeviceQuotePageKey)
class SubmitDeviceQuoteScreen extends BaseScreen<BaseArguments> {
  static const String pageKey = "QC_submit_device_quote_screen";
  static const String route = "/submit_device_quote";

  const SubmitDeviceQuoteScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
