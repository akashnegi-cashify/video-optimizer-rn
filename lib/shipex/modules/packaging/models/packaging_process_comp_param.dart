import 'package:csh_annotation/annotation.dart';

import 'group_lot_list_repsonse.dart';

@CshPageParam()
class PackagingProcessCompParam {
  @ParamKey(key: PackagingProcessCompParamKeys.dataModel)
  GroupLotListData? dataModel;

  @ParamKey(key: PackagingProcessCompParamKeys.isPending)
  bool? isGroupLotPending;

  @ParamKey(key: PackagingProcessCompParamKeys.isCCTVSelected, defaultValue: false)
  bool? isCCTVSelected;

  PackagingProcessCompParam({
    this.dataModel,
    this.isGroupLotPending,
    this.isCCTVSelected,
  });
}

enum PackagingProcessCompParamKeys with AbsParamKey {
  dataModel('dm'),
  isPending('ip'),
  isCCTVSelected("isCCTV");

  @override
  final String value;

  const PackagingProcessCompParamKeys(this.value);
}
