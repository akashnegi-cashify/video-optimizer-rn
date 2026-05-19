import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

import '../widgets/shipex_packaging_widget.dart';

part 'shipex_packing_component.g.dart';

@CshComponent(
    key: ShipexPackingComponent.COMP_KEY,
    componentGroup: ComponentGroup.shipexPackingComponentKey,
    configModel: NoneConfigModel)
class ShipexPackingComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "packing_component";

  const ShipexPackingComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const ShipexPackagingWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
