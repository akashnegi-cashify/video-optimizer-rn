import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../models/create_shipment_param.dart';
import '../widgets/create_shipment_widget.dart';

part 'create_shipment_component.g.dart';

@CshComponent(
    key: CreateShipmentComponent.COMP_KEY,
    componentGroup: ComponentGroup.createShipmentComponentKey,
    paramModel: CreateShipmentParam,
    params: CreateShipmentParamKeys.values,
    configModel: NoneConfigModel)
class CreateShipmentComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "create_shipment";

  const CreateShipmentComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, NoneConfigModel? configModel) {
    return paramBuilder((param) {
      return CreateShipmentWidget(paramModel: param);
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
