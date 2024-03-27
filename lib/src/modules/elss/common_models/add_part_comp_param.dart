import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_part.dart';

@CshPageParam()
class AddPartCompParam {
  @ParamKey(key: AddPartCompParamKey.scannedBarcode)
  String? scannedBarcode;

  @ParamKey(key: AddPartCompParamKey.selectedParts)
  List<ElssPart>? selectedPartList;

  AddPartCompParam({this.scannedBarcode, this.selectedPartList});
}

enum AddPartCompParamKey with AbsParamKey {
  scannedBarcode("sb"),
  selectedParts("sp");

  @override
  final String value;

  const AddPartCompParamKey(this.value);
}
