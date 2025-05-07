import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../../common_models/allowed_option_comp_param.dart';
import '../../common_models/elss_device_details_response.dart';

part 'allowed_option_screen.g.dart';

class AllowedOptionScreeArguments {
  final String scannedBarcode;
  final ElssDeviceDetailsResponse? detailsDataModel;
  final String? pQuoteId;
  final String? remarks;

  AllowedOptionScreeArguments(this.scannedBarcode, {this.detailsDataModel, this.pQuoteId, this.remarks});
}

@CshPage(
    key: AllowedOptionScreen.pageKey,
    params: AllowedOptionCompParamKeys.values,
    pageGroup: PageGroup.allowedOptionPageKey)
class AllowedOptionCompScreenArguments extends BaseArguments {
  final AllowedOptionScreeArguments? arguments;

  AllowedOptionCompScreenArguments({this.arguments}) : super(AllowedOptionScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[AllowedOptionCompParamKeys.arguments.value] = arguments;
    return data;
  }
}

class AllowedOptionScreen extends BaseScreen<AllowedOptionCompScreenArguments> {
  static const String pageKey = "TRC_allowed_option_screen";
  static const String route = "/allowed_option_screen";

  const AllowedOptionScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
