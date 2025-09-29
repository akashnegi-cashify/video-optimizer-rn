import 'package:csh_annotation/annotation.dart';

import '../elss_trc/screens/add_device_media_screen_trc.dart';

@CshPageParam()
class AddDeviceMediaCompParam {
  @ParamKey(key: AddDeviceMediaCompParamKeys.addDeviceMediaArg)
  AddDeviceMediaArgumentsTrc? addDeviceMediaArgumentsTrc;

  AddDeviceMediaCompParam({
    this.addDeviceMediaArgumentsTrc,
  });
}

enum AddDeviceMediaCompParamKeys with AbsParamKey {
  addDeviceMediaArg("arg");

  @override
  final String value;

  const AddDeviceMediaCompParamKeys(this.value);
}
