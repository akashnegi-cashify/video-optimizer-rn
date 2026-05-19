import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/facility_list/models/facility_list_param_model.dart';
import 'package:flutter_trc/src/common/facility_list/resources/facility_list_response.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/rms_groups.dart';

part 'facility_list_screen.g.dart';

class FacilityListScreenArg extends BaseArguments {
  Function(FacilityListData facility) onFacilitySelected;

  FacilityListScreenArg(this.onFacilitySelected) : super(FacilityListScreen.pageKey);

  Map<String, dynamic> toJson() {
    return {
      FacilityListPageParamKeys.facilitySelected.value: onFacilitySelected,
    };
  }
}

@CshPage(
  key: FacilityListScreen.pageKey,
  pageGroup: RmsPageGroup.rmsFacilityListPageKey,
  params: FacilityListPageParamKeys.values,
)
class FacilityListScreen extends BaseScreen<FacilityListScreenArg> {
  static const String pageKey = "RMS_facility_list_screen";
  static const String route = "/rms/facility_list";

  const FacilityListScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arg = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: arg?.toJson());
  }

  static openFacilityScreen(BuildContext context, {required Function(FacilityListData facility) onFacilitySelected}) {
    Navigator.pushNamed(context, route, arguments: FacilityListScreenArg(onFacilitySelected));
  }
}
