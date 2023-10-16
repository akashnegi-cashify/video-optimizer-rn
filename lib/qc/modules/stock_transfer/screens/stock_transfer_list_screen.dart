import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'stock_transfer_list_screen.g.dart';

@CshPage(key: StockTransferListScreen.pageKey, pageGroup: QcPageGroup.qcStockTransferListPageKey)
class StockTransferListScreen extends BaseScreen {
  static const String pageKey = "QC_stock_transfer_list_screen";
  static const String route = "/qc_stock_transfer_list";

  const StockTransferListScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}