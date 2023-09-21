import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../models/product_detail_comp_params.dart';
import '../models/validate_awb_response.dart';

part 'stock_in_product_detail_screen.g.dart';

class StockInProductDetailScreenArguments extends BaseArguments {
  ValidateAwbResponse? stockInProductDetail;

  StockInProductDetailScreenArguments(
    super.pageKey,
    this.stockInProductDetail,
  );
}

@CshPage(
  key: StockInProductDetailScreen.pageKey,
)
// todo ask page grp

class StockInProductDetailScreen extends BaseScreen<StockInProductDetailScreenArguments> {
  static const String pageKey = "QC_qc_stock_in_product_detail";
  static const String route = "/stock-in-product-detail";

  const StockInProductDetailScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: {
        ProductDetailCompParamKeys.stockInProductDetail.value: args?.stockInProductDetail,
      },
    );
  }

  static navigate(BuildContext context, {ValidateAwbResponse? arguments}) {
    Navigator.pushNamed(context, route, arguments: StockInProductDetailScreenArguments(pageKey, arguments));
  }
}
