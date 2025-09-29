import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class DeviceReportCompParam {
  @ParamKey(key: DeviceReportCompParamKeys.deviceId)
  String? deviceId;

  DeviceReportCompParam({
    this.deviceId,
  });
}

enum DeviceReportCompParamKeys with AbsParamKey {
  deviceId("did");

  @override
  final String value;

  const DeviceReportCompParamKeys(this.value);
}
