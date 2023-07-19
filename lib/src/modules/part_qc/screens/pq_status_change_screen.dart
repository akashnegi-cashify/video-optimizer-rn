import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../models/pq_status_change_comp_param.dart';
import '../models/qc_parts_list_response.dart';

part 'pq_status_change_screen.g.dart';

@CshPage(
    key: PartQcPartStatusScreen.pageKey,
    pageGroup: PageGroup.pqStatusChangePageKey,
    params: PqStatusChangeCompParamKeys.values)
class PartQcPartStatusScreenArguments extends BaseArguments {
  final QcPartListData? partDetails;

  PartQcPartStatusScreenArguments({this.partDetails}) : super(PartQcPartStatusScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[PqStatusChangeCompParamKeys.partDetails.value] = partDetails;
    return data;
  }
}

class PartQcPartStatusScreen extends BaseScreen<PartQcPartStatusScreenArguments> {
  static const String pageKey = "TRC_part_qc_part_status_screen";
  static const String route = "/part_qc_part_status_screen";

  const PartQcPartStatusScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
