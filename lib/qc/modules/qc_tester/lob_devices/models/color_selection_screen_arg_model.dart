import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class ColorSelectionScreenArgModel {
  @ParamKey(key: ColorSelectionScreenArgModelKeys.deviceBarcode)
  String? deviceBarcode;

  @ParamKey(key: ColorSelectionScreenArgModelKeys.productId)
  int? productId;

  @ParamKey(key: ColorSelectionScreenArgModelKeys.onColorSelected)
  Function(String color, String? strapColor)? onColorSelected;

  ColorSelectionScreenArgModel({this.deviceBarcode, this.productId, this.onColorSelected});
}

enum ColorSelectionScreenArgModelKeys with AbsParamKey {
  deviceBarcode('dbr'),
  productId('bid'),
  onColorSelected('ocs');

  @override
  final String value;

  const ColorSelectionScreenArgModelKeys(this.value);
}
