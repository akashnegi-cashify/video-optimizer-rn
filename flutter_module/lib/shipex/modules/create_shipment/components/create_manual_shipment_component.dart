import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../models/create_manual_shipment_param.dart';
import '../widgets/create_manual_shipment_widget.dart';

part 'create_manual_shipment_component.g.dart';

@CshComponent(
    key: CreateManualShipmentComponent.COMP_KEY,
    componentGroup: ComponentGroup.createManualShipmentComponentKey,
    paramModel: CreateManualShipmentParam,
    params: CreateManualShipmentParamKeys.values,
    configModel: NoneConfigModel)
class CreateManualShipmentComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "create_manual_shipment_comp";

  const CreateManualShipmentComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, NoneConfigModel? configModel) {
    return paramBuilder((param) {
      return CreateManualShipmentWidget(
        params: param,
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
