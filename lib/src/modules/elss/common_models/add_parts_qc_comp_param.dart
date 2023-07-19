import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class AddPartsQCCompParam {
  @ParamKey(key: AddPartsQCCompParamKeys.scannedBarcode)
  String? scannedBarcode;

  AddPartsQCCompParam({
    this.scannedBarcode,
  });
}

enum AddPartsQCCompParamKeys with AbsParamKey {
  scannedBarcode("sb");

  @override
  final String value;

  const AddPartsQCCompParamKeys(this.value);
}
