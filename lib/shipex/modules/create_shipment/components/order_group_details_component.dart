import 'package:builder_component/builder_component.dart';
import 'package:core/core.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../models/group_order_comp_params.dart';
import '../widgets/order_group_details_widget.dart';

part 'order_group_details_component.g.dart';

@CshComponent(
    key: OrderGroupDetailsComponent.COMP_KEY,
    componentGroup: ComponentGroup.orderGroupDetailsComponentKey,
    params: GroupOrderCompParamsKeys.values,
    paramModel: GroupOrderCompParams,
    configModel: NoneConfigModel)
class OrderGroupDetailsComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "order_group_details_comp";

  const OrderGroupDetailsComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((param) {
      Logger.debug('mydebug------OrderGroupDetailsComponent.buildView', [param.shipmentStatus]);
      return OrderGroupDetailsWidget(
        groupId: param.groupId ?? "",
        shipmentId: param.shipmentId ?? "",
        courierAwb: param.courierAwb ?? "",
        lotName: param.lotName ?? "",
        devicesQuantity: param.devicesQuantity ?? 0,
        pinCode: param.pinCode ?? "",
        shipmentStatus: param.shipmentStatus ?? 0,
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
