import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/pending_dispatch/models/complete_dispatch_param_model.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'complete_dispatch_screen.g.dart';

class CompleteDispatchScreenArg extends BaseArguments {
  String deliveryPartnerKey;

  CompleteDispatchScreenArg(this.deliveryPartnerKey) : super(CompleteDispatchScreen.pageKey);

  Map<String, dynamic> toJson() => {CompleteDispatchParamModelKeys.deliveryPartnerKey.value: deliveryPartnerKey};
}

@CshPage(
    key: CompleteDispatchScreen.pageKey,
    pageGroup: PageGroup.completeDispatchPageKey,
    params: CompleteDispatchParamModelKeys.values)
class CompleteDispatchScreen extends BaseScreen<CompleteDispatchScreenArg> {
  static const String pageKey = "OMS_complete_dispatch_screen";
  static const String route = "/complete_dispatch_screen";

  const CompleteDispatchScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return PageWidget(pageKey: pageKey, initialValue: getArguments(context)?.toJson());
  }

  static navigate(BuildContext context, String deliveryPartnerKey) {
    Navigator.pushNamed(context, route, arguments: CompleteDispatchScreenArg(deliveryPartnerKey));
  }
}
