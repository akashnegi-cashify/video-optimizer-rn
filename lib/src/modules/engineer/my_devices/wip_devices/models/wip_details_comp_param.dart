import 'package:csh_annotation/annotation.dart';

import '../../../models/engineer_device_info.dart';

@CshPageParam()
class WipDetailsCompParam {
  @ParamKey(key: WipDetailsCompParamKeys.engineerDeviceInfo)
  EngineerDeviceInfo? engineerDeviceInfo;

  WipDetailsCompParam({
    this.engineerDeviceInfo,
  });
}

enum WipDetailsCompParamKeys with AbsParamKey {
  engineerDeviceInfo("edi");

  @override
  final String value;

  const WipDetailsCompParamKeys(this.value);
}
