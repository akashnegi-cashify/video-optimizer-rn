import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class AddPartCompParam {
  @ParamKey(key: AddPartCompParamKey.scannedBarcode)
  String? scannedBarcode;

  AddPartCompParam({this.scannedBarcode});
}

enum AddPartCompParamKey with AbsParamKey {
  scannedBarcode("sb");

  @override
  final String value;

  const AddPartCompParamKey(this.value);
}
