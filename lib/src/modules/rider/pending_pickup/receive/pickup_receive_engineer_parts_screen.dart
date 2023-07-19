import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../../pending_delivery/deliver/models/delivery_response.dart';
import 'models/pickup_receive_engineer_parts_param.dart';

part 'pickup_receive_engineer_parts_screen.g.dart';

@CshPage(
    key: PickUpReceiveEngineerPartsScreen.pageKey,
    pageGroup: PageGroup.pickUpReceiveEngineerPageKey,
    params: PickUpReceiveEngineerPartsParamsKeys.values)
class PickUpReceiveEngineerPartsScreenArguments extends BaseArguments {
  final EngineerDetail? engineerDetail;

  PickUpReceiveEngineerPartsScreenArguments({this.engineerDetail}) : super(PickUpReceiveEngineerPartsScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[PickUpReceiveEngineerPartsParamsKeys.engineerDetails.value] = engineerDetail;
    return data;
  }
}

class PickUpReceiveEngineerPartsScreen extends BaseScreen<PickUpReceiveEngineerPartsScreenArguments> {
  static const String pageKey = "TRC_pickup_receive_engineer_parts_screen";
  static const String route = "/pickup_receive_engineer_parts_screen";

  const PickUpReceiveEngineerPartsScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);

    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
