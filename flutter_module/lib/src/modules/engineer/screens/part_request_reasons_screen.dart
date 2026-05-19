import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/modules/engineer/models/part_request_reasons_comp_model.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/order_engineer_part.dart';

part 'part_request_reasons_screen.g.dart';

class PartRequestReasonsScreenArg extends BaseArguments {
  List<OrderEngineerPart> requestedParts;
  Function(List<OrderEngineerPart> partList)? onReasonsSubmitted;

  PartRequestReasonsScreenArg(this.requestedParts, {this.onReasonsSubmitted}) : super(PartRequestReasonsScreen.pageKey);

  Map<String, dynamic> toJson() {
    return {
      PartRequestReasonsCompParamKeys.partRequestList.value: requestedParts,
      PartRequestReasonsCompParamKeys.onReasonSubmitted.value: onReasonsSubmitted,
    };
  }
}

@CshPage(
  key: PartRequestReasonsScreen.pageKey,
  pageGroup: PageGroup.trcPartRequestReasonsPageKey,
  params: PartRequestReasonsCompParamKeys.values,
)
class PartRequestReasonsScreen extends BaseScreen<PartRequestReasonsScreenArg> {
  static const String pageKey = "TRC_part_request_reasons_screen";
  static const String route = "/trc_part_request_reasons_page";

  const PartRequestReasonsScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arg = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: arg?.toJson(),
    );
  }
}
