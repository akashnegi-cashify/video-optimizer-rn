import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../../src/app_builder/app_builder_groups/qc_groups.dart';

part 'dispatch_lot_screen.g.dart';

@CshPage(key: DispatchLotScreen.pageKey, pageGroup: QcPageGroup.qcDispatchLot)
class DispatchLotScreen extends BaseScreen {
  static const String pageKey = "QC_qc_dispatch_lot";
  static const String route = "/dispatch-lot";

  const DispatchLotScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
