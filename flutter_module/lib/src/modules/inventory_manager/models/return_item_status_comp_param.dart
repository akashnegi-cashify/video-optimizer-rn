import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/return_part_response.dart';

@CshPageParam()
class ReturnItemStatusCompParam {
  @ParamKey(key: ReturnItemStatusCompParamKeys.detailsData)
  ReturnItemData? detailsModel;

  ReturnItemStatusCompParam({
    this.detailsModel,
  });
}

enum ReturnItemStatusCompParamKeys with AbsParamKey {
  detailsData("dd");

  @override
  final String value;

  const ReturnItemStatusCompParamKeys(this.value);
}
