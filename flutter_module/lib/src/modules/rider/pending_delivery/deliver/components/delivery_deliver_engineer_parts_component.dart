import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../../../pending_pickup/receive/models/pickup_receive_engineer_parts_param.dart';
import '../widgets/delivery_deliver_engineer_parts_widget.dart';

part 'delivery_deliver_engineer_parts_component.g.dart';

@CshComponent(
    key: DeliveryDeliverEngineerPartsComponent.COMP_KEY,
    configModel: NoneConfigModel,
    params: PickUpReceiveEngineerPartsParamsKeys.values,
    componentGroup: ComponentGroup.deliveryDeliverEngineerPartsComponentKey,
    paramModel: PickUpReceiveEngineerPartsParams)
class DeliveryDeliverEngineerPartsComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_delivery_deliver_engineer_parts";

  const DeliveryDeliverEngineerPartsComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder(
      (param) {
        return DeliveryDeliverEngineerPartsWidget(
          engineerDetail: param.engineerDetail,
        );
      },
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
