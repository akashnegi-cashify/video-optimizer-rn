import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/src/common/facility_list/resources/facility_list_response.dart';

@CshPageParam()
class FacilityListPageParamModel {
  @ParamKey(key: FacilityListPageParamKeys.facilitySelected)
  Function(FacilityListData facility)? onFacilitySelected;

  FacilityListPageParamModel({this.onFacilitySelected});
}

enum FacilityListPageParamKeys with AbsParamKey {
  facilitySelected("fs");

  @override
  final String value;

  const FacilityListPageParamKeys(this.value);
}
