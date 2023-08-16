import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class UploadEwayBillParams {
  @ParamKey(key: UploadEwayBillParamsKeys.facilityId)
  int? facilityId;
  @ParamKey(key: UploadEwayBillParamsKeys.shipmentId)
  String? shipmentId;

  UploadEwayBillParams({
    this.shipmentId,
    this.facilityId,
  });
}

enum UploadEwayBillParamsKeys with AbsParamKey {
  shipmentId("sid"),
  facilityId("fid");

  @override
  final String value;

  const UploadEwayBillParamsKeys(this.value);
}
