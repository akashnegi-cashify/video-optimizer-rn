import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../../src/app_builder/app_builder_groups/qc_groups.dart';

part 'dispatch_lot_filter_screen.g.dart';

@CshPage(key: DispatchLotFilterScreen.pageKey, pageGroup: QcPageGroup.qcDispatchLotFilter)
class DispatchLotFilterScreen extends BaseScreen {
  static const String pageKey = "QC_qc_dispatch_lot_filter";
  static const String route = "/dispatch-lot-filter";

  const DispatchLotFilterScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }

  static Future navigate(BuildContext context){
   return Navigator.pushNamed(context, route);
  }
}
