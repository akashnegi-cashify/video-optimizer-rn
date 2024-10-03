import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/models/product_list_screen_arg_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/src/common/searchable.dart';
import 'package:provider/provider.dart';

class ProductListProvider extends CalculatorServiceInitProvider with Searchable {
  late final String? deviceBarcode;
  late final int? brandId;
  late final int? categoryId;
  late final List<CategoryData>? categoryList;

  ProductListProvider(ProductListScreenArgModel model) {
    deviceBarcode = model.deviceBarcode;
    brandId = model.brandId;
    categoryId = model.categoryId;
    categoryList = model.categoryList;
  }

  static ProductListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ProductListProvider>(context, listen: listen);
  }

  Future<List<LobProductListData>?> getProductsList(int pageNo, int pageSize) {
    var completer = Completer<List<LobProductListData>?>();
    service
        .getProductList(deviceBarcode, brandId, categoryId,
            pageNo: pageNo, pageSize: pageSize, searchQuery: searchQuery)
        .listen((event) {
      if (!Validator.isListNullOrEmpty(event?.productList)) {
        completer.complete(event?.productList);
      } else {
        completer.completeError("Product List is empty");
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  bool isAllowedVariants() {
    for (CategoryData category in categoryList ?? []) {
      if (category.id == categoryId) {
        return category.allowVariant ?? false;
      }
    }
    return false;
  }
}
