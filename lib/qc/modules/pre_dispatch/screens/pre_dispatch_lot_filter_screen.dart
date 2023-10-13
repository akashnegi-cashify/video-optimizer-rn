import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../../src/app_builder/app_builder_groups/qc_groups.dart';

part 'pre_dispatch_lot_filter_screen.g.dart';

@CshPage(key: PreDispatchLotFilterScreen.pageKey, pageGroup: QcPageGroup.qcPreDispatchLotFilter)
class PreDispatchLotFilterScreen extends BaseScreen {
  static const String pageKey = "QC_qc_pre_dispatch_lot_filter";
  static const String route = "/pre_dispatch-lot-filter";

  const PreDispatchLotFilterScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }

  static Future navigate(BuildContext context){
   return Navigator.pushNamed(context, route);
  }
}
