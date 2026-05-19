import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../models/create_manual_shipment_param.dart';
import '../providers/manual_shipment_provider.dart';

part 'create_manual_shipment_screen.g.dart';

@CshPage(
    key: CreateManualShipmentScreen.pageKey,
    pageGroup: PageGroup.createManualShipmentPageKey,
    params: CreateManualShipmentParamKeys.values)
class CreateManualShipmentScreenArguments extends BaseArguments {
  final int? facilityId;
  final int? groupId;
  final int? boxId;
  final String? pinCode;
  final bool? isManualShipment;
  final int? shipmentId;

  CreateManualShipmentScreenArguments({
    this.facilityId,
    this.boxId,
    this.groupId,
    this.pinCode,
    this.isManualShipment,
    this.shipmentId,
  }) : super(CreateManualShipmentScreen.pageKey);

  Map<String, dynamic> toJson() {
    return {
      CreateManualShipmentParamKeys.groupId.value: groupId,
      CreateManualShipmentParamKeys.boxId.value: boxId,
      CreateManualShipmentParamKeys.facilityId.value: facilityId,
      CreateManualShipmentParamKeys.pinCode.value: pinCode,
      CreateManualShipmentParamKeys.isManualShipment.value: isManualShipment,
      CreateManualShipmentParamKeys.shipmentId.value: shipmentId,
    };
  }
}

class CreateManualShipmentScreen extends BaseScreen<CreateManualShipmentScreenArguments> {
  static const String pageKey = "create_manual_shipment_screen";
  static const String route = "/create_manual_shipment_screen";

  const CreateManualShipmentScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
      setProviders: (BuildContext insideContext) {
        return [
          ChangeNotifierProvider<ManualShipmentProvider>(
            create: (_) => ManualShipmentProvider(
              pincode: args?.pinCode,
              groupId: args?.groupId ?? 0,
              boxId: args?.boxId,
              facilityId: args?.facilityId,
              shipmentId: args?.shipmentId,
            ),
            lazy: false,
          ),
        ];
      },
    );
  }
}
