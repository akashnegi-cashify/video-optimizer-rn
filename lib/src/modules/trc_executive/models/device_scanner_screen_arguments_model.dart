import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/tl_list_response.dart';

@CshPageParam()
class DeviceScannerScreenArgumentsModel {
  @ParamKey(key: DeviceScannerScreenArgumentsModelParams.tlUser)
  TlListData? tlUserData;

  DeviceScannerScreenArgumentsModel({this.tlUserData});
}

enum DeviceScannerScreenArgumentsModelParams with AbsParamKey {
  tlUser("tlUser");

  @override
  final String value;

  const DeviceScannerScreenArgumentsModelParams(this.value);
}
