import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class PartSelectionQCCompParam {
  @ParamKey(key: PartSelectionQCCompParamKeys.scannedBarcode)
  String? scannedBarcode;

  @ParamKey(key: PartSelectionQCCompParamKeys.remarks)
  String? remarks;

  @ParamKey(key: PartSelectionQCCompParamKeys.pQuoteId)
  String? pQuoteId;

  PartSelectionQCCompParam({
    this.scannedBarcode,
    this.remarks,
    this.pQuoteId,
  });
}

enum PartSelectionQCCompParamKeys with AbsParamKey {
  scannedBarcode("sb"),
  remarks("r"),
  pQuoteId("pqId");

  @override
  final String value;

  const PartSelectionQCCompParamKeys(this.value);
}
