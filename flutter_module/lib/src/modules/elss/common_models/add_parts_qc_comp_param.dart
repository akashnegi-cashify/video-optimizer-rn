import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_part.dart';

@CshPageParam()
class AddPartsQCCompParam {
  @ParamKey(key: AddPartsQCCompParamKeys.scannedBarcode)
  String? scannedBarcode;

  @ParamKey(key: AddPartsQCCompParamKeys.selectedParts)
  List<ElssPart>? selectedParts;

  AddPartsQCCompParam({
    this.scannedBarcode,
    this.selectedParts,
  });
}

enum AddPartsQCCompParamKeys with AbsParamKey {
  scannedBarcode("sb"),
  selectedParts("sp");


  @override
  final String value;

  const AddPartsQCCompParamKeys(this.value);
}
