import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';

@CshPageParam()
class ProductListScreenArgModel {
  @ParamKey(key: ProductListScreenArgModelKeys.deviceBarcode)
  String? deviceBarcode;

  @ParamKey(key: ProductListScreenArgModelKeys.imei)
  String? imei;

  @ParamKey(key: ProductListScreenArgModelKeys.brandId)
  int? brandId;

  @ParamKey(key: ProductListScreenArgModelKeys.categoryId)
  int? categoryId;

  @ParamKey(key: ProductListScreenArgModelKeys.categoryList)
  List<CategoryData>? categoryList;

  @ParamKey(key: ProductListScreenArgModelKeys.onProductSelected)
  Function(LobProductListData productItem, VariantListData? variantItem) onProductSelected;

  ProductListScreenArgModel(
      {this.deviceBarcode, this.imei, this.brandId, this.categoryId, required this.onProductSelected, this.categoryList});
}

enum ProductListScreenArgModelKeys with AbsParamKey {
  deviceBarcode('dbr'),
  brandId('bid'),
  categoryId('cid'),
  categoryList('cat'),
  imei('imei'),
  onProductSelected('ops');

  @override
  final String value;

  const ProductListScreenArgModelKeys(this.value);
}
