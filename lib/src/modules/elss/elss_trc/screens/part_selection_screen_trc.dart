import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../../common_models/part_selection_comp_param.dart';

part 'part_selection_screen_trc.g.dart';

@CshPage(
    key: PartSelectionScreenTrc.pageKey,
    pageGroup: PageGroup.partSelectionPageKey,
    params: PartSelectionCompParamKeys.values)
class PartSelectionScreenTrcArguments extends BaseArguments {
  final String? barcode;

  PartSelectionScreenTrcArguments({this.barcode}) : super(PartSelectionScreenTrc.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[PartSelectionCompParamKeys.scannedBarcode.value] = barcode;
    return data;
  }
}

class PartSelectionScreenTrc extends BaseScreen<PartSelectionScreenTrcArguments> {
  static const String pageKey = "TRC_part_selection_trc";
  static const route = '/part_selection_screen_trc';

  const PartSelectionScreenTrc({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
