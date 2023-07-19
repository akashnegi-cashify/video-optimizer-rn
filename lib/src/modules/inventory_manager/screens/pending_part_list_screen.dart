import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../app_builder/app_builder_groups/groups.dart';
import '../models/pending_device_list_response.dart';
import '../models/pending_part_list_comp_param.dart';

part 'pending_part_list_screen.g.dart';

class PendingPartListScreenArguments {
  final PendingDeviceDetailData? detailsModelData;
  final int did;

  PendingPartListScreenArguments({
    this.detailsModelData,
    required this.did,
  });
}

@CshPage(
    key: PendingPartListScreen.pageKey,
    params: PendingPartListCompParamKeys.values,
    pageGroup: PageGroup.pendingPartListPageKey)
class PendingPartListCompScreenArguments extends BaseArguments {
  final PendingPartListScreenArguments? arguments;

  PendingPartListCompScreenArguments({this.arguments}) : super(PendingPartListScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[PendingPartListCompParamKeys.arguments.value] = arguments;
    return data;
  }
}

class PendingPartListScreen extends BaseScreen<PendingPartListCompScreenArguments> {
  static const String pageKey = "TRC_pending_part_list_screen";
  static const String route = "/pending_part_list_screen";

  const PendingPartListScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
