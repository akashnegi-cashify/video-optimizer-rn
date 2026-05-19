import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import 'models/group_lot_list_repsonse.dart';
import 'models/packaging_process_comp_param.dart';

part 'packaging_process_screen.g.dart';

@CshPage(
  key: PackagingProcessScreen.pageKey,
  pageGroup: PageGroup.packagingProcessPageKey,
  params: PackagingProcessCompParamKeys.values,
)
class PackagingProcessScreenArguments extends BaseArguments {
  final GroupLotListData? dataModel;
  final bool isPendingGroupLot;
  final bool isCCTCCameraSelected;

  PackagingProcessScreenArguments({this.dataModel, this.isPendingGroupLot = false, this.isCCTCCameraSelected = false})
      : super(PackagingProcessScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[PackagingProcessCompParamKeys.dataModel.value] = dataModel;
    data[PackagingProcessCompParamKeys.isPending.value] = isPendingGroupLot;
    data[PackagingProcessCompParamKeys.isCCTVSelected.value] = isCCTCCameraSelected;
    return data;
  }
}

class PackagingProcessScreen extends BaseScreen<PackagingProcessScreenArguments> {
  static const String pageKey = "packaging_process_screen";
  static const String route = "/packaging_process_screen";

  const PackagingProcessScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
