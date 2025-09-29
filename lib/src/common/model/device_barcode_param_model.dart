import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class DeviceBarcodeParamModel {
  @ParamKey(key: DeviceBarcodeParamKeys.deviceBarcode)
  String? deviceBarcode;

  DeviceBarcodeParamModel({
    this.deviceBarcode,
  });
}

enum DeviceBarcodeParamKeys with AbsParamKey {
  deviceBarcode("dbr");

  @override
  final String value;

  const DeviceBarcodeParamKeys(this.value);
}
