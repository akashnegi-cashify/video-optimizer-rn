import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/qc/modules/external_audit/external_audit_perform_screen.dart';
import 'package:flutter_trc/qc/modules/external_audit/models/external_audit_enum.dart';

import 'validate_awb_response.dart';

@CshPageParam()
class ProductDetailCompParam {
  @ParamKey(key: ProductDetailCompParamKeys.stockInProductDetail)
  ValidateAwbResponse? stockInProductDetail;

  @ParamKey(key: ProductDetailCompParamKeys.awbNumber)
  String? awbNumber;

  @ParamKey(key: ProductDetailCompParamKeys.barcode)
  String? barcode;

  ProductDetailCompParam({this.stockInProductDetail, this.awbNumber, this.barcode});
}

enum ProductDetailCompParamKeys with AbsParamKey {
  stockInProductDetail("stockInProductDetail"),
  awbNumber("awbNumber"),
  barcode("barcode");

  @override
  final String value;

  const ProductDetailCompParamKeys(this.value);
}
