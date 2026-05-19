import 'package:csh_annotation/annotation.dart';

import '../../../pending_delivery/deliver/models/delivery_response.dart';

@CshPageParam()
class PickUpReceiveEngineerPartsParams {
  @ParamKey(key: PickUpReceiveEngineerPartsParamsKeys.engineerDetails)
  EngineerDetail? engineerDetail;

  PickUpReceiveEngineerPartsParams({
    this.engineerDetail,
  });
}

enum PickUpReceiveEngineerPartsParamsKeys with AbsParamKey {
  engineerDetails("ed");

  @override
  final String value;

  const PickUpReceiveEngineerPartsParamsKeys(this.value);
}
