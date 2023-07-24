import 'package:csh_annotation/annotation.dart';

import 'group_list_repsonse_data_model.dart';

@CshPageParam()
class PackagingProcessCompParam {
  @ParamKey(key: PackagingProcessCompParamKeys.dataModel)
  GroupListDataResponse? dataModel;

  PackagingProcessCompParam({
    this.dataModel,
  });
}

enum PackagingProcessCompParamKeys with AbsParamKey {
  dataModel('dm');

  @override
  final String value;

  const PackagingProcessCompParamKeys(this.value);
}
