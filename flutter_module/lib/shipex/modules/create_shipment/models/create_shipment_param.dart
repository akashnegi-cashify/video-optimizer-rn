import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class CreateShipmentParam {
  @ParamKey(key: CreateShipmentParamKeys.groupId)
  String? groupId;
  @ParamKey(key: CreateShipmentParamKeys.pinCode)
  String? pinCode;
  @ParamKey(key: CreateShipmentParamKeys.shipmentId)
  int? shipmentId;
  @ParamKey(key: CreateShipmentParamKeys.facilityId)
  int? facilityId;
  @ParamKey(key: CreateShipmentParamKeys.lotName)
  String? lotName;
  @ParamKey(key: CreateShipmentParamKeys.devicesQuantity)
  int? devicesQuantity;

  CreateShipmentParam({
    this.lotName,
    this.devicesQuantity,
    this.shipmentId,
    this.facilityId,
    this.groupId,
    this.pinCode,
  });
}

enum CreateShipmentParamKeys with AbsParamKey {
  devicesQuantity("dq"),
  lotName("ln"),
  groupId("gid"),
  pinCode("p"),
  shipmentId("sid"),
  facilityId("fid");

  @override
  final String value;

  const CreateShipmentParamKeys(this.value);
}
