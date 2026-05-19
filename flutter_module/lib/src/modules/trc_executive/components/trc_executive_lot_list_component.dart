import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/modules/trc_executive/widgets/trc_executive_lot_list_widget.dart';

import '../../../app_builder/app_builder_groups/groups.dart';

part 'trc_executive_lot_list_component.g.dart';

@CshComponent(
  key: TrcExecutiveLotListComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: ComponentGroup.trcExecutiveLotListComponentKey,
)
class TrcExecutiveLotListComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_trc_executive_lot_list_component";

  const TrcExecutiveLotListComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const TrcExecutiveLotListWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
