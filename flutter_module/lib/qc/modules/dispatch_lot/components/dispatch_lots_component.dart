import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/providers/dispatch_lot_provider.dart';
import 'package:provider/provider.dart';

import '../../../../src/app_builder/app_builder_groups/qc_groups.dart';
import '../../../../src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import '../widgets/index.dart';

part 'dispatch_lots_component.g.dart';

@CshComponent(
  key: DispatchLotsComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: QcComponentGroup.qcDispatchLotsComponentKey,
)
class DispatchLotsComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_qc_dispatch_lots_component";

  const DispatchLotsComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return ChangeNotifierProvider(
      create: (_) => DispatchLotProvider(),
      child: DispatchLotContainer(),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
