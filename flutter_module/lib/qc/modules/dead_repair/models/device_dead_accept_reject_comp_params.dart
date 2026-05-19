import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class DeviceDeadAcceptRejectCompParam {
  @ParamKey(key: DeviceDeadAcceptRejectCompParamKeys.header)
  String? header;

  @ParamKey(key: DeviceDeadAcceptRejectCompParamKeys.code)
  String? code;

  @ParamKey(key: DeviceDeadAcceptRejectCompParamKeys.selectedReason)
  String? selectedReason;

  @ParamKey(key: DeviceDeadAcceptRejectCompParamKeys.markId)
  int? markId;

  DeviceDeadAcceptRejectCompParam({
    this.header,
    this.code,
    this.markId,
    this.selectedReason,
  });
}

enum DeviceDeadAcceptRejectCompParamKeys with AbsParamKey {
  header("h"),
  code("code"),
  selectedReason("sr"),
  markId("mi");
  @override
  final String value;

  const DeviceDeadAcceptRejectCompParamKeys(this.value);
}
