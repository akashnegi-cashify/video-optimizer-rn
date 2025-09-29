import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'trc_and_qc_login_screen.g.dart';

@CshPage(key: TrcAndQcLoginScreen.pageKey, pageGroup: PageGroup.trcAndQcLoginPageKey)
class TrcAndQcLoginScreen extends BaseScreen {
  static const String pageKey = "TRC_trc_and_qc_login_screen";
  static const String route = "/trc_qnd_qc_login_screen";

  const TrcAndQcLoginScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
