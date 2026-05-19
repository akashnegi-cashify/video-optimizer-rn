import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../model/received_rubbing_device_comp_param.dart';

part 'received_rubbing_devices_screen.g.dart';

@CshPage(
  key: ReceivedRubbingDevicesScreen.pageKey,
  pageGroup: PageGroup.receiveRubbingDevicePageKey,
  params: ReceivedRubbingDeviceCompParamKeys.values,
)
class ReceivedRubbingDevicesScreenArguments extends BaseArguments {
  final String? searchQuery;

  ReceivedRubbingDevicesScreenArguments({this.searchQuery}) : super(ReceivedRubbingDevicesScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[ReceivedRubbingDeviceCompParamKeys.searchQuery.value] = searchQuery;
    return data;
  }
}

class ReceivedRubbingDevicesScreen extends BaseScreen<ReceivedRubbingDevicesScreenArguments> {
  static const String pageKey = "TRC_receive_rubbing_device_screen";
  static const String route = "/receive_rubbing_device_screen";

  const ReceivedRubbingDevicesScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
