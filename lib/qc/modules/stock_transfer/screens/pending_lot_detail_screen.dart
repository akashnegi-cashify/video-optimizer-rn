import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/st_store_out_param_model.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'pending_lot_detail_screen.g.dart';

class PendingLotDetailScreenArguments extends BaseArguments {
  int? lotId;

  PendingLotDetailScreenArguments(this.lotId) : super(PendingLotDetailScreen.pageKey);

  Map<String, dynamic> toJson() {
    return {StStoreOutParamModelKeys.lotId.value: lotId};
  }
}

@CshPage(key: PendingLotDetailScreen.pageKey, pageGroup: QcPageGroup.qcStockTransferPendingLotDetailPageKey)
class PendingLotDetailScreen extends BaseScreen<PendingLotDetailScreenArguments> {
  static const String pageKey = "QC_st_pending_lot_detail_screen";
  static const String route = "/qc_pending_lot_detail_screen";

  const PendingLotDetailScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arg = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: arg?.toJson());
  }

  static PendingLotDetailScreenArguments arguments(int lotId) {
    return PendingLotDetailScreenArguments(lotId);
  }
}
