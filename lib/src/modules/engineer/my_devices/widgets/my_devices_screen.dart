import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'my_devices_screen.g.dart';

@CshPage(key: MyDevicesScreen.pageKey, pageGroup: PageGroup.myDevicesPageKey)
class MyDevicesScreen extends BaseScreen {
  static const String pageKey = "TRC_my_devices";
  static const String route = "/my_devices_screen";

  const MyDevicesScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
