import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';

import '../models/retrieved_parts_data_details_param.dart';

part 'retrieved_parts_details_data_screen.g.dart';

@CshPage(
  key: RetrievedPartsDataDetailsScreen.pageKey,
  pageGroup: PageGroup.retrievedPartsDataDetailsPageKey,
  params: RetrievedDataDetailsParamModelKeys.values,
)
class RetrievedPartsDataDetailsScreenArguments extends BaseArguments {
  final VoidCallback? onSuccess;
  final EngineerPartInfo? partInfo;

  RetrievedPartsDataDetailsScreenArguments({
    this.onSuccess,
    this.partInfo,
  }) : super(RetrievedPartsDataDetailsScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[RetrievedDataDetailsParamModelKeys.partInfo.value] = partInfo;
    data[RetrievedDataDetailsParamModelKeys.onSuccess.value] = onSuccess;
    return data;
  }
}

class RetrievedPartsDataDetailsScreen extends BaseScreen<RetrievedPartsDataDetailsScreenArguments> {
  static const String pageKey = "TRC_retrieved_parts_details";
  static const String route = "/retrieved_parts_data_details";

  const RetrievedPartsDataDetailsScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: args?.toJson());
  }
}
