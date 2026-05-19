import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../models/assigned_device_details_comp_param.dart';

part 'assigned_device_details_screen.g.dart';

@CshPage(
    key: AssignedDeviceDetailsScreen.pageKey,
    params: AssignedDeviceDetailsCompParamKeys.values,
    pageGroup: PageGroup.assignedDeviceDetailsPageKey)
class AssignedDeviceDetailsScreenArguments extends BaseArguments {
  final int? did;

  AssignedDeviceDetailsScreenArguments({this.did}) : super(AssignedDeviceDetailsScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[AssignedDeviceDetailsCompParamKeys.did.value] = did;
    return data;
  }
}

class AssignedDeviceDetailsScreen extends BaseScreen<AssignedDeviceDetailsScreenArguments> {
  static const String pageKey = "TRC_assigned_device_details";
  static const String route = "/assigned_Device_details_screen";

  const AssignedDeviceDetailsScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
