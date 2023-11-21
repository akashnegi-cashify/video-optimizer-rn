import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/supervisor/models/supervisor_param_model.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'supervisor_screen.g.dart';

class SupervisorScreenArguments extends BaseArguments {
  final String deviceBarcode;

  SupervisorScreenArguments(this.deviceBarcode) : super(SupervisorScreen.pageKey);

  Map<String, dynamic> toJson() {
    return {SupervisorParamModelKeys.deviceBarcode.value: deviceBarcode};
  }
}

@CshPage(
  key: SupervisorScreen.pageKey,
  pageGroup: QcPageGroup.qcSupervisorPageKey,
  params: SupervisorParamModelKeys.values,
)
class SupervisorScreen extends BaseScreen<SupervisorScreenArguments> {
  static const String pageKey = "QC_supervisor_screen";
  static const String route = "/supervisor-screen";

  const SupervisorScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arg = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: arg?.toJson());
  }

  static void navigate(BuildContext context, String deviceBarcode) {
    Navigator.pushNamed(context, SupervisorScreen.route, arguments: SupervisorScreenArguments(deviceBarcode));
  }
}