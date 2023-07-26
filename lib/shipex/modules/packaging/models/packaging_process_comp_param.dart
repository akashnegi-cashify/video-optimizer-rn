import 'package:csh_annotation/annotation.dart';

import 'group_lot_list_repsonse.dart';

@CshPageParam()
class PackagingProcessCompParam {
  @ParamKey(key: PackagingProcessCompParamKeys.dataModel)
  GroupLotListData? dataModel;

  @ParamKey(key: PackagingProcessCompParamKeys.isPending)
  bool? isGroupLotPending;

  PackagingProcessCompParam({
    this.dataModel,
    this.isGroupLotPending,
  });
}

enum PackagingProcessCompParamKeys with AbsParamKey {
  dataModel('dm'),
  isPending('ip');

  @override
  final String value;

  const PackagingProcessCompParamKeys(this.value);
}
