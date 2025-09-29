import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../models/create_shipment_param.dart';
import '../providers/create_shipment_provider.dart';

part 'create_shipment_screen.g.dart';

@CshPage(
    key: CreateShipmentScreen.pageKey,
    pageGroup: PageGroup.createShipmentPageKey,
    params: CreateShipmentParamKeys.values)
class CreateShipmentScreenArguments extends BaseArguments {
  final String? groupId;

  final String? pinCode;

  final int? shipmentId;

  final int? facilityId;
  final String? lotName;
  final int? devicesQuantity;

  CreateShipmentScreenArguments({
    this.pinCode,
    this.groupId,
    this.facilityId,
    this.shipmentId,
    this.devicesQuantity,
    this.lotName,
  }) : super(CreateShipmentScreen.pageKey);

  Map<String, dynamic> toJson() {
    return {
      CreateShipmentParamKeys.facilityId.value: facilityId,
      CreateShipmentParamKeys.groupId.value: groupId,
      CreateShipmentParamKeys.pinCode.value: pinCode,
      CreateShipmentParamKeys.shipmentId.value: shipmentId,
      CreateShipmentParamKeys.devicesQuantity.value: devicesQuantity,
      CreateShipmentParamKeys.lotName.value: lotName,
    };
  }
}

class CreateShipmentScreen extends BaseScreen<CreateShipmentScreenArguments> {
  static const String pageKey = "create_shipment_screen";
  static const String route = "/create_shipment_screen";

  const CreateShipmentScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
      setProviders: (BuildContext insideContext) {
        return [
          ChangeNotifierProvider<CreateShipmentProvider>(
            create: (_) => CreateShipmentProvider(pincode: args?.pinCode, groupId: args?.groupId),
            lazy: false,
          )
        ];
      },
    );
  }
}
