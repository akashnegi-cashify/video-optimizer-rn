import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../../../../src/app_builder/app_headers/qc_general_header/models/qc_general_header_param.dart';

part 'store_out_screen.g.dart';

@CshPage(
  key: StoreOutScreen.pageKey,
  pageGroup: PageGroup.qcStoreOutKey,
)
class StoreOutScreen extends BaseScreen {
  static const String pageKey = "QC_qc_store_out";
  static const String route = "/qc-store-out";

  const StoreOutScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return PageWidget(
      pageKey: pageKey,
      initialValue: {QcGeneralHeaderParamKeys.header.value: "Store Out"},
    );
  }

  static Future navigateTo(BuildContext context) {
    return Navigator.pushReplacementNamed(context, route);
  }
}
