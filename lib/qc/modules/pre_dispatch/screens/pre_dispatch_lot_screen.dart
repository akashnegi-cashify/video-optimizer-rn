import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../../src/app_builder/app_builder_groups/qc_groups.dart';

part 'pre_dispatch_lot_screen.g.dart';

@CshPage(key: PreDispatchLotScreen.pageKey, pageGroup: QcPageGroup.qcPreDispatchLot)
class PreDispatchLotScreen extends BaseScreen {
  static const String pageKey = "QC_qc_pre_dispatch_lot";
  static const String route = "/pre-dispatch-lot";

  const PreDispatchLotScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
