import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class PendingDeliveryCompParam {
  @ParamKey(key: PendingDeliveryCompParamKeys.id)
  int? id;

  PendingDeliveryCompParam({this.id});
}

enum PendingDeliveryCompParamKeys with AbsParamKey {
  id("id");

  @override
  final String value;

  const PendingDeliveryCompParamKeys(this.value);
}
