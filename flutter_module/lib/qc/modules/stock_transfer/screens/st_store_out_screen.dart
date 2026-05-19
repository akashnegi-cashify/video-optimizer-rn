import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/st_store_out_param_model.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'st_store_out_screen.g.dart';

class StStoreOutScreenArguments extends BaseArguments {
  int? lotId;

  StStoreOutScreenArguments(this.lotId) : super(StStoreOutScreen.pageKey);

  Map<String, dynamic> toJson() {
    return {StStoreOutParamModelKeys.lotId.value: lotId};
  }
}

@CshPage(
  key: StStoreOutScreen.pageKey,
  pageGroup: QcPageGroup.qcStockTransferStoreOutPageKey,
  params: StStoreOutParamModelKeys.values,
)
class StStoreOutScreen extends BaseScreen<StStoreOutScreenArguments> {
  static const String pageKey = "QC_stock_transfer_store_out_screen";
  static const String route = "/QC_stock_transfer_store_out_screen";

  const StStoreOutScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arguments = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: arguments?.toJson());
  }

  static StStoreOutScreenArguments arguments(int lotId) {
    return StStoreOutScreenArguments(lotId);
  }

}
