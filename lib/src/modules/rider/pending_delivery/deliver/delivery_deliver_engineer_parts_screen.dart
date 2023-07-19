import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../../pending_pickup/receive/models/pickup_receive_engineer_parts_param.dart';
import 'models/delivery_response.dart';

part 'delivery_deliver_engineer_parts_screen.g.dart';

@CshPage(
  key: DeliveryDeliverEngineerPartsScreen.pageKey,
  pageGroup: PageGroup.deliveryDeliverEngineerPartsPageKey,
  params: PickUpReceiveEngineerPartsParamsKeys.values,
)
class DeliveryDeliverEngineerPartsScreenArguments extends BaseArguments {
  final EngineerDetail? engineerDetail;

  DeliveryDeliverEngineerPartsScreenArguments({
    this.engineerDetail,
  }) : super(DeliveryDeliverEngineerPartsScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[PickUpReceiveEngineerPartsParamsKeys.engineerDetails.value] = engineerDetail;
    return data;
  }
}

class DeliveryDeliverEngineerPartsScreen extends BaseScreen<DeliveryDeliverEngineerPartsScreenArguments> {
  static const String pageKey = "TRC_delivery_deliver_engineer_parts_screen";
  static const String route = "/delivery_deliver_engineer_parts_screen";

  const DeliveryDeliverEngineerPartsScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
