import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/order_engineer_part.dart';

@CshPageParam()
class PartRequestReasonsCompParam {
  @ParamKey(key: PartRequestReasonsCompParamKeys.partRequestList)
  List<OrderEngineerPart> partRequestList;

  @ParamKey(key: PartRequestReasonsCompParamKeys.onReasonSubmitted)
  Function(List<OrderEngineerPart> partList)? onReasonsSubmitted;

  PartRequestReasonsCompParam({required this.partRequestList, this.onReasonsSubmitted});
}

enum PartRequestReasonsCompParamKeys with AbsParamKey {
  partRequestList("prl"),
  onReasonSubmitted("rs");

  @override
  final String value;

  const PartRequestReasonsCompParamKeys(this.value);
}
