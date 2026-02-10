import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../src/app_builder/app_builder_groups/qc_groups.dart';
import '../../../../src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import '../providers/pre_dispatch_lot_provider.dart';
import '../widgets/index.dart';

part 'pre_dispatch_lots_component.g.dart';

@CshComponent(
  key: PreDispatchLotsComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: QcComponentGroup.qcPreDispatchLotsComponentKey,
)
class PreDispatchLotsComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_qc_pre_dispatch_lots_component";

  const PreDispatchLotsComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PreDispatchLotProvider(),
      child: PreDispatchLotContainer(),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
