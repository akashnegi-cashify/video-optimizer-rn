import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../models/group_order_comp_params.dart';

part 'sub_order_group_detail_screen.g.dart';

@CshPage(
    key: SubOrderGroupDetailsScreen.pageKey,
    pageGroup: PageGroup.orderGroupDetailsPageKey,
    params: GroupOrderCompParamsKeys.values)
class SubOrderGroupDetailsScreenArguments extends BaseArguments {
  final String? groupId;
  final String? courierAwb;
  final String? shipmentId;
  final int? facilityId;
  final String? lotName;
  final int? devicesQuantity;
  final String? pinCode;

  SubOrderGroupDetailsScreenArguments({
    this.groupId,
    this.courierAwb,
    this.shipmentId,
    this.facilityId,
    this.lotName,
    this.devicesQuantity,
    this.pinCode,
  }) : super(SubOrderGroupDetailsScreen.pageKey);

  Map<String, dynamic> toJson() {
    return {
      GroupOrderCompParamsKeys.groupId.value: groupId,
      GroupOrderCompParamsKeys.shipmentId.value: shipmentId,
      GroupOrderCompParamsKeys.courierAwb.value: courierAwb,
      GroupOrderCompParamsKeys.devicesQuantity.value: devicesQuantity,
      GroupOrderCompParamsKeys.lotName.value: lotName,
      GroupOrderCompParamsKeys.pinCode.value: pinCode,
    };
  }
}

class SubOrderGroupDetailsScreen extends BaseScreen<SubOrderGroupDetailsScreenArguments> {
  static const String pageKey = "sub_order_group_details_screen";
  static const String route = "/sub_order_group_details_screen";

  const SubOrderGroupDetailsScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);

    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
