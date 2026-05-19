import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/elss_status.dart';

import '../../common_models/elss_status_comp_param.dart';

part 'elss_status_screen.g.dart';

class ElssStatusScreenArg {
  ElssStatus elssStatus;
  final String barcode;

  ElssStatusScreenArg({
    required this.elssStatus,
    required this.barcode,
  });
}

@CshPage(
  key: ElssStatusScreen.pageKey,
  pageGroup: PageGroup.elssStatusPageKey,
  params: ElssStatusCompParamKeys.values,
)
class ElssStatusCompArguments extends BaseArguments {
  final ElssStatusScreenArg? arguments;

  ElssStatusCompArguments({
    this.arguments,
  }) : super(ElssStatusScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[ElssStatusCompParamKeys.arguments.value] = arguments;
    return data;
  }
}

class ElssStatusScreen extends BaseScreen<ElssStatusCompArguments> {
  static const String pageKey = "TRC_elss_status_screen";
  static String routeName = "/elss-status";

  const ElssStatusScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
