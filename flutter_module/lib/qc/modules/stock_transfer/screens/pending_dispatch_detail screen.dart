import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/pending_dispatch_detail_param_model.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'pending_dispatch_detail screen.g.dart';

class PendingDispatchDetailScreenArguments extends BaseArguments {
  final String? lotName;
  final String? scannedInvoiceNo;

  PendingDispatchDetailScreenArguments({
    this.lotName,
    this.scannedInvoiceNo,
  }) : super(PendingDispatchDetailScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[PendingDispatchDetailParamModelKeys.lotName.value] = lotName;
    data[PendingDispatchDetailParamModelKeys.invoiceNo.value] = scannedInvoiceNo;
    return data;
  }
}

@CshPage(
  key: PendingDispatchDetailScreen.pageKey,
  pageGroup: QcPageGroup.qcStockTransferPendingDispatchDetailPageKey,
  params: PendingDispatchDetailParamModelKeys.values,
)
class PendingDispatchDetailScreen extends BaseScreen<PendingDispatchDetailScreenArguments> {
  static const String pageKey = "QC_st_pending_dispatch_detail_screen";
  static const String route = "/stock_transfer_pending_dispatch_detail_screen";

  const PendingDispatchDetailScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arg = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: arg?.toJson());
  }

  static PendingDispatchDetailScreenArguments arguments(String lotName, String? invoiceNo) {
    return PendingDispatchDetailScreenArguments(lotName: lotName, scannedInvoiceNo: invoiceNo);
  }
}
