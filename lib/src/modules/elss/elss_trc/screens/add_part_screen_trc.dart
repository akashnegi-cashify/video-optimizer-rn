import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../../app_builder/app_builder_groups/groups.dart';
import '../../common_models/add_part_comp_param.dart';

part 'add_part_screen_trc.g.dart';

@CshPage(key: AddPartScreenTrc.pageKey, pageGroup: PageGroup.addPartPageKey, params: AddPartCompParamKey.values)
class AddPartScreenTrcArguments extends BaseArguments {
  final String? barcode;

  AddPartScreenTrcArguments({this.barcode}) : super(AddPartScreenTrc.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[AddPartCompParamKey.scannedBarcode.value] = barcode;
    return data;
  }
}

class AddPartScreenTrc extends BaseScreen<AddPartScreenTrcArguments> {
  static const String pageKey = "TRC_add_part_screen_trc";
  static const route = '/add_part_screen_trc';

  const AddPartScreenTrc({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
