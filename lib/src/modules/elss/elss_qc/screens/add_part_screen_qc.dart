import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_part.dart';

import '../../common_models/add_parts_qc_comp_param.dart';

part 'add_part_screen_qc.g.dart';

@CshPage(key: AddPartScreenQc.pageKey, params: AddPartsQCCompParamKeys.values, pageGroup: PageGroup.addPartsQCPageKey)
class AddPartScreenQcArguments extends BaseArguments {
  final String? scannedBarcode;
  final List<ElssPart>? elssPartList;


  AddPartScreenQcArguments({this.scannedBarcode, this.elssPartList}) : super(AddPartScreenQc.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[AddPartsQCCompParamKeys.scannedBarcode.value] = scannedBarcode;
    data[AddPartsQCCompParamKeys.selectedParts.value] = elssPartList;
    return data;
  }
}

class AddPartScreenQc extends BaseScreen<AddPartScreenQcArguments> {
  static const String pageKey = "TRC_add_part_screen_qc";
  static const route = '/add_part_screen_qc';

  const AddPartScreenQc({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
