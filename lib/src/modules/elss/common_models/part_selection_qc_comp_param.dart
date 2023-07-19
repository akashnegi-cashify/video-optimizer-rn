import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class PartSelectionQCCompParam {
  @ParamKey(key: PartSelectionQCCompParamKeys.scannedBarcode)
  String? scannedBarcode;

  PartSelectionQCCompParam({
    this.scannedBarcode,
  });
}

enum PartSelectionQCCompParamKeys with AbsParamKey {
  scannedBarcode("sb");

  @override
  final String value;

  const PartSelectionQCCompParamKeys(this.value);
}
