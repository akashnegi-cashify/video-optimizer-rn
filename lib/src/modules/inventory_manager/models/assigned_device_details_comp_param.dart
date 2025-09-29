import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class AssignedDeviceDetailsCompParam {
  @ParamKey(key: AssignedDeviceDetailsCompParamKeys.did)
  int? did;

  AssignedDeviceDetailsCompParam({this.did});
}

enum AssignedDeviceDetailsCompParamKeys with AbsParamKey {
  did("did");

  @override
  final String value;

  const AssignedDeviceDetailsCompParamKeys(this.value);
}
