import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/st_store_out_param_model.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/pending_lot_detail_provider.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/widgets/pending_lot_detail_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

part 'pending_lot_detail_component.g.dart';

@CshComponent(
  key: PendingLotDetailComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: QcComponentGroup.qcStockTransferPendingLotDetailComponentKey,
  params: StStoreOutParamModelKeys.values,
  paramModel: StStoreOutParamModel,
)
class PendingLotDetailComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_st_pending_lot_detail_component";

  const PendingLotDetailComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((model) {
      return ChangeNotifierProvider(
        create: (_) => PendingLotDetailProvider(model.lotId),
        child: const PendingLotDetailWidget(),
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
