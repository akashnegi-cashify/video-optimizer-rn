import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../../models/retreived_part_required_list_reponse.dart';
import '../../my_devices/wip_devices/view_parts/models/order_engineer_part.dart';
import '../models/retrieved_parts_data_details_param.dart';
import '../providers/retrieved_part_data_provider.dart';

part 'retrieved_parts_details_data_screen.g.dart';

@CshPage(
  key: RetrievedPartsDataDetailsScreen.pageKey,
  pageGroup: PageGroup.retrievedPartsDataDetailsPageKey,
  params: RetrievedDataDetailsParamModelKeys.values,
)
class RetrievedPartsDataDetailsScreenArguments extends BaseArguments {
  final RetrievedPartRequiredResponse? dataModel;
  final String? deviceBarcode;
  final bool? inProgressCase;
  final List<OrderEngineerPart>? orderDataList;

  RetrievedPartsDataDetailsScreenArguments({
    this.dataModel,
    this.deviceBarcode,
    this.orderDataList,
    this.inProgressCase = true,
  }) : super(RetrievedPartsDataDetailsScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[RetrievedDataDetailsParamModelKeys.dataModel.value] = dataModel;
    data[RetrievedDataDetailsParamModelKeys.deviceBarcode.value] = deviceBarcode;
    data[RetrievedDataDetailsParamModelKeys.inProgressCase.value] = inProgressCase;
    data[RetrievedDataDetailsParamModelKeys.orderPartDataList.value] = orderDataList;
    return data;
  }
}

class RetrievedPartsDataDetailsScreen extends BaseScreen<RetrievedPartsDataDetailsScreenArguments> {
  static const String pageKey = "TRC_retrieved_parts_details";
  static const String route = "/retrieved_parts_data_details";

  const RetrievedPartsDataDetailsScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
      setProviders: (BuildContext context) {
        return [
          ChangeNotifierProvider<RetrievedPartsDataProviders>(
            create: (_) => RetrievedPartsDataProviders(
              args?.dataModel,
              deviceBarcode: args?.deviceBarcode,
              isDeviceInProgress: args?.inProgressCase,
              orderDataList: args?.orderDataList,
            ),
            lazy: false,
          )
        ];
      },
    );
  }
}
