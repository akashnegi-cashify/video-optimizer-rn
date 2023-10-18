import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_out/models/index.dart';

import '../../../../src/app_builder/app_builder_groups/qc_groups.dart';

part 'lot_items_scan_screen.g.dart';

@CshPage(
  key: LotItemsScanScreen.pageKey,
  pageGroup: QcPageGroup.qcStoreOutLotItemsScanPageKey,
  params: LotItemsScanCompParamKeys.values,
)
class LotItemsScanScreen extends BaseScreen<LotItemsScanScreenArgs> {
  static const String pageKey = "QC_qc_lot_items_scan";
  static const String route = "/lot-items-scan";

  const LotItemsScanScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: {
        LotItemsScanCompParamKeys.header.value: "Lot Item Details",
        LotItemsScanCompParamKeys.lotType.value: args?.lotType,
        LotItemsScanCompParamKeys.lotName.value: args?.lotName,
      },
    );
  }

  static Future navigate(BuildContext context, {String? lotName, int? lotType}) {
    return Navigator.pushNamed(
      context,
      route,
      arguments: LotItemsScanScreenArgs(
        LotItemsScanScreen.pageKey,
        lotType: lotType,
        lotName: lotName,
      ),
    );
  }
}

class LotItemsScanScreenArgs extends BaseArguments {
  int? lotType;
  String? lotName;

  LotItemsScanScreenArgs(super.pageKey, {this.lotType, this.lotName});
}
