import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/models/product_list_screen_arg_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'product_list_screen.g.dart';

class ProductListScreenArg extends BaseArguments {
  final String deviceBarcode;
  final int categoryId;
  final int brandId;
  final List<CategoryData> categoryList;
  final Function(LobProductListData productItem, VariantListData? variantItem) onProductSelected;

  ProductListScreenArg({
    required this.deviceBarcode,
    required this.categoryId,
    required this.brandId,
    required this.onProductSelected,
    required this.categoryList,
  }) : super(ProductListScreen.pageKey);

  Map<String, dynamic> toJson() => {
        ProductListScreenArgModelKeys.deviceBarcode.value: deviceBarcode,
        ProductListScreenArgModelKeys.categoryId.value: categoryId,
        ProductListScreenArgModelKeys.brandId.value: brandId,
        ProductListScreenArgModelKeys.categoryList.value: categoryList,
        ProductListScreenArgModelKeys.onProductSelected.value: onProductSelected,
      };
}

@CshPage(
  key: ProductListScreen.pageKey,
  pageGroup: QcPageGroup.qcProductListPageKey,
  params: ProductListScreenArgModelKeys.values,
)
class ProductListScreen extends BaseScreen<ProductListScreenArg> {
  static const String pageKey = "QC_product_list_screen";
  static const String route = "/qc-tester/lob-devices/product-list";

  const ProductListScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arg = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: arg?.toJson());
  }

  static void navigateTo(
    BuildContext context,
    String deviceBarcode,
    int selectedCategoryId,
    int brandId,
    List<CategoryData> categoryList,
    Function(LobProductListData productItem, VariantListData? variantItem) onProductSelected,
  ) {
    Navigator.pushNamed(context, ProductListScreen.route,
        arguments: ProductListScreenArg(
            deviceBarcode: deviceBarcode,
            categoryId: selectedCategoryId,
            brandId: brandId,
            onProductSelected: (productItem, variantItem) {
              Navigator.pop(context); // pop this screen
              onProductSelected(productItem, variantItem);
            },
            categoryList: categoryList));
  }
}
