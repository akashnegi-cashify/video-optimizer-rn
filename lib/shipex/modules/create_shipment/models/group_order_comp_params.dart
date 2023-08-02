import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class GroupOrderCompParams {
  @ParamKey(key: GroupOrderCompParamsKeys.groupId)
  String? groupId;
  @ParamKey(key: GroupOrderCompParamsKeys.shipmentId)
  String? shipmentId;
  @ParamKey(key: GroupOrderCompParamsKeys.courierAwb)
  String? courierAwb;
  @ParamKey(key: GroupOrderCompParamsKeys.lotName)
  String? lotName;
  @ParamKey(key: GroupOrderCompParamsKeys.devicesQuantity)
  int? devicesQuantity;
  @ParamKey(key: GroupOrderCompParamsKeys.pinCode)
  String? pinCode;

  GroupOrderCompParams({
    this.pinCode,
    this.devicesQuantity,
    this.lotName,
    this.groupId,
    this.shipmentId,
    this.courierAwb,
  });
}

enum GroupOrderCompParamsKeys with AbsParamKey {
  pinCode("pn"),
  devicesQuantity("dq"),
  lotName("ln"),
  courierAwb("ca"),
  shipmentId("si"),
  groupId("gi");

  @override
  final String value;

  const GroupOrderCompParamsKeys(this.value);
}
