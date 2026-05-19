import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/tl_list_response.dart';

@CshPageParam()
class DeviceScannerScreenArgumentsModel {

  @ParamKey(key: DeviceScannerScreenArgumentsModelParams.storageBarcode)
  String? storageBarcode;

  DeviceScannerScreenArgumentsModel({this.storageBarcode});
}

enum DeviceScannerScreenArgumentsModelParams with AbsParamKey {
  storageBarcode("sbr");

  @override
  final String value;

  const DeviceScannerScreenArgumentsModelParams(this.value);
}
