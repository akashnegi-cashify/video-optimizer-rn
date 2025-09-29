import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../common_models/elss_home_comp_param.dart';

part 'elss_home_screen.g.dart';

@CshPage(key: ElssHomeScreen.pageKey, params: ElssHomeCompParamKeys.values, pageGroup: PageGroup.elssHomePageKey)
class ElssHomeScreenArguments extends BaseArguments {
  final bool? isLogicFromQC;

  ElssHomeScreenArguments({this.isLogicFromQC}) : super(ElssHomeScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[ElssHomeCompParamKeys.isLogicFromQC.value] = isLogicFromQC;
    return data;
  }
}

class ElssHomeScreen extends BaseScreen<ElssHomeScreenArguments> {
  static const String pageKey = "TRC_elss_home_screen";
  static const route = "/elss-home-screen";

  const ElssHomeScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
