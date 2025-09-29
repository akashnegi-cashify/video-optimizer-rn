import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'device_receive_screen.g.dart';

@CshPage(key: DeviceReceiveScreen.pageKey, pageGroup: PageGroup.deviceReceivePageKey)
class DeviceReceiveScreen extends BaseScreen {
  static const String pageKey = "device_receive";
  static const String route = "/device-receive";

  const DeviceReceiveScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
