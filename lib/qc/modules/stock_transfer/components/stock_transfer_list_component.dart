import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/widgets/stock_transfer_list_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

part 'stock_transfer_list_component.g.dart';

@CshComponent(
    key: StockTransferListComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: QcComponentGroup.qcStockTransferListComponentKey)
class StockTransferListComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_stock_transfer_list_component";

  const StockTransferListComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const StockTransferListWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
