import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../models/pending_delivery_comp_param.dart';

part 'pending_delivery_screen.g.dart';

@CshPage(
    key: PendingDeliveryScreen.pageKey,
    params: PendingDeliveryCompParamKeys.values,
    pageGroup: PageGroup.pendingDeliveryPageKey)
class PendingDeliveryScreenCompArguments extends BaseArguments {
  final int? id;

  PendingDeliveryScreenCompArguments({this.id}) : super(PendingDeliveryScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[PendingDeliveryCompParamKeys.id.value] = id;
    return data;
  }
}

class PendingDeliveryScreen extends BaseScreen<PendingDeliveryScreenCompArguments> {
  static const String pageKey = "TRC_pending_delivery_screen";
  static const String route = "/pending_delivery_screen";

  const PendingDeliveryScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
