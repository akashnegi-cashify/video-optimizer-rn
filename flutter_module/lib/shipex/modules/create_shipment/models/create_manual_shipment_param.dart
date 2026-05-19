import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class CreateManualShipmentParam {
  @ParamKey(key: CreateManualShipmentParamKeys.facilityId)
  int? facilityId;
  @ParamKey(key: CreateManualShipmentParamKeys.groupId)
  int? groupId;
  @ParamKey(key: CreateManualShipmentParamKeys.boxId)
  int? boxId;
  @ParamKey(key: CreateManualShipmentParamKeys.pinCode)
  String? pinCode;
  @ParamKey(key: CreateManualShipmentParamKeys.isManualShipment)
  bool? isManualShipment;
  @ParamKey(key: CreateManualShipmentParamKeys.shipmentId)
  int? shipmentId;

  CreateManualShipmentParam({
    this.shipmentId,
    this.pinCode,
    this.groupId,
    this.boxId,
    this.facilityId,
    this.isManualShipment,
  });
}

enum CreateManualShipmentParamKeys with AbsParamKey {
  shipmentId("sid"),
  isManualShipment("ms"),
  pinCode("pc"),
  facilityId("fid"),
  boxId("bid"),
  groupId("gid");

  @override
  final String value;

  const CreateManualShipmentParamKeys(this.value);
}
