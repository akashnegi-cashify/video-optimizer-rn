import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class PartSelectionCompParam {
  @ParamKey(key: PartSelectionCompParamKeys.scannedBarcode)
  String? scannedBarcode;

  PartSelectionCompParam({
    this.scannedBarcode,
  });
}

enum PartSelectionCompParamKeys with AbsParamKey {
  scannedBarcode("sb");

  @override
  final String value;

  const PartSelectionCompParamKeys(this.value);
}
