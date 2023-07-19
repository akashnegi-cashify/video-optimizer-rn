import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../models/return_item_status_comp_param.dart';
import '../models/return_part_response.dart';

part 'return_item_status_screen.g.dart';

@CshPage(
    key: ReturnStatusScreen.pageKey,
    params: ReturnItemStatusCompParamKeys.values,
    pageGroup: PageGroup.returnItemStatusPageKey)
class ReturnStatusScreenArguments extends BaseArguments {
  final ReturnItemData? detailsModel;

  ReturnStatusScreenArguments({this.detailsModel}) : super(ReturnStatusScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[ReturnItemStatusCompParamKeys.detailsData.value] = detailsModel;
    return data;
  }
}

class ReturnStatusScreen extends BaseScreen<ReturnStatusScreenArguments> {
  static const String pageKey = "TRC_return_status_screen";
  static const String route = "/return_status_screen";

  const ReturnStatusScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
