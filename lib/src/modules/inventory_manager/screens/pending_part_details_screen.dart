import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../models/pending_device_list_response.dart';
import '../models/pending_part_details_comp_param.dart';

part 'pending_part_details_screen.g.dart';

class PendingPartDetailsScreenArguments {
  final PendingDeviceDetailData? detailsModelData;
  final int prid;
  final int statusCode;

  PendingPartDetailsScreenArguments({
    required this.prid,
    this.detailsModelData,
    required this.statusCode,
  });
}

@CshPage(
    key: PendingPartDetailsScreen.pageKey,
    params: PendingPartDetailsCompParamKeys.values,
    pageGroup: PageGroup.pendingPartDetailsPageKey)
class PendingPartDetailsCompScreenArguments extends BaseArguments {
  final PendingPartDetailsScreenArguments? arguments;

  PendingPartDetailsCompScreenArguments({
    this.arguments,
  }) : super(PendingPartDetailsScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[PendingPartDetailsCompParamKeys.arguments.value] = arguments;
    return data;
  }
}

class PendingPartDetailsScreen extends BaseScreen<PendingPartDetailsCompScreenArguments> {
  static const String pageKey = "TRC_pending_part_details_screen";
  static const String route = '/pending_part_details_screen';

  const PendingPartDetailsScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);

    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
