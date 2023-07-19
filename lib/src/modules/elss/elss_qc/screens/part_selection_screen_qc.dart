import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../../common_models/part_selection_qc_comp_param.dart';

part 'part_selection_screen_qc.g.dart';

@CshPage(
    key: PartSelectionScreenQc.pageKey,
    params: PartSelectionQCCompParamKeys.values,
    pageGroup: PageGroup.partSelectionQCPageKey)
class PartSelectionScreenArguments extends BaseArguments {
  final String? scannedBarcode;

  PartSelectionScreenArguments({this.scannedBarcode}) : super(PartSelectionScreenQc.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[PartSelectionQCCompParamKeys.scannedBarcode.value] = scannedBarcode;
    return data;
  }
}

class PartSelectionScreenQc extends BaseScreen<PartSelectionScreenArguments> {
  static const String pageKey = "TRC_part_selection_qc";
  static const route = '/part_selection_screen_qc';

  const PartSelectionScreenQc({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
