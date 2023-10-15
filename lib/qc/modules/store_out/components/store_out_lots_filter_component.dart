import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../../src/app_builder/app_builder_groups/qc_groups.dart';
import '../../../../src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import '../widgets/index.dart';
import '../widgets/store_out_lot_filter_widget.dart';

part 'store_out_lots_filter_component.g.dart';

@CshComponent(
  key: StoreOutLotsFilterComponent.COMP_KEY,
  configModel: NoneConfigModel,
    componentGroup: QcComponentGroup.qcStoreOutLotsFilterComponentKey
)
class StoreOutLotsFilterComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_qc_store_out_lots_filter_component";

  const StoreOutLotsFilterComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const StoreOutLotFilterWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
