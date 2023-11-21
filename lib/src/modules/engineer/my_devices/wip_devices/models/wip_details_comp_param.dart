import 'package:csh_annotation/annotation.dart';

import '../../../models/engineer_device_info.dart';

@CshPageParam()
class WipDetailsCompParam {
  @ParamKey(key: WipDetailsCompParamKeys.deviceBarcode)
  String? deviceBarcode;

  WipDetailsCompParam({
    this.deviceBarcode,
  });
}

enum WipDetailsCompParamKeys with AbsParamKey {
  deviceBarcode("dbr");

  @override
  final String value;

  const WipDetailsCompParamKeys(this.value);
}
