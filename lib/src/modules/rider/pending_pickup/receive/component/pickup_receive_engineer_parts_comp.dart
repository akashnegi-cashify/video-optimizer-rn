import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../models/pickup_receive_engineer_parts_comp_config.dart';
import '../models/pickup_receive_engineer_parts_param.dart';
import '../widgets/pickup_receive_engineer_parts_widget.dart';

part 'pickup_receive_engineer_parts_comp.g.dart';

@CshComponent(
    key: PickUpReceiveEngineerPartsCompo.COMP_KEY,
    configModel: PickupReceiveEngineerPartsCompConfig,
    componentGroup: ComponentGroup.pickUpReceiveEngineerPartsCompo,
    paramModel: PickUpReceiveEngineerPartsParams,
    params: PickUpReceiveEngineerPartsParamsKeys.values)
class PickUpReceiveEngineerPartsCompo extends StatelessComponent<PickupReceiveEngineerPartsCompConfig> {
  static const String COMP_KEY = "TRC_pickup_receive_engineer_parts_comp";

  const PickUpReceiveEngineerPartsCompo(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((param) {
      return PickupReceiveEngineerPartsWidget(
        paramModel: param,
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return PickupReceiveEngineerPartsCompConfig.fromConfig;
  }
}
