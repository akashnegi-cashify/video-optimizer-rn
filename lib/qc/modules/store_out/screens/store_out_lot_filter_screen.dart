import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../../src/app_builder/app_builder_groups/qc_groups.dart';

part 'store_out_lot_filter_screen.g.dart';

@CshPage(key: StoreOutLotFilterScreen.pageKey, pageGroup: QcPageGroup.qcStoreOutLotFilterPageKey)
class StoreOutLotFilterScreen extends BaseScreen {
  static const String pageKey = "QC_qc_store_out_lot_filter";
  static const String route = "/store-out-lot-filter";

  const StoreOutLotFilterScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(
      pageKey: pageKey,
      initialValue: {"h": "Lot Type"},
    );
  }

  static Future navigate(BuildContext context) {
    return Navigator.pushNamed(context, route);
  }
}
