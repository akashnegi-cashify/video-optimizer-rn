import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/qc/modules/external_audit/external_audit_perform_screen.dart';
import 'package:flutter_trc/qc/modules/external_audit/models/external_audit_enum.dart';

import 'validate_awb_response.dart';

@CshPageParam()
class ProductDetailCompParam {
  @ParamKey(key: ProductDetailCompParamKeys.stockInProductDetail)
  ValidateAwbResponse? stockInProductDetail;

  ProductDetailCompParam({required this.stockInProductDetail});
}

enum ProductDetailCompParamKeys with AbsParamKey {
  stockInProductDetail("stockInProductDetail");

  @override
  final String value;

  const ProductDetailCompParamKeys(this.value);
}
