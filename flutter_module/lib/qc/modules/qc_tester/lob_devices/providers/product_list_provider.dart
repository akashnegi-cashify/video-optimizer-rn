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
  String? imei;
  bool isShowImeiSearch = false;
  bool isShowLoading = true;
  List<LobProductListData>? _productListAccToImei;

  ProductListProvider(ProductListScreenArgModel model) {
    deviceBarcode = model.deviceBarcode;
    brandId = model.brandId;
    categoryId = model.categoryId;
    categoryList = model.categoryList;
    imei = model.imei;
    isShowImeiSearch = _isShowImeiSearch(categoryList, categoryId);
  }

  void setSearchQuery(String? value) {
    searchQuery = value;
    notifyListeners();
  }

  List<LobProductListData>? get productListAccToImei => Validator.isNullOrEmpty(searchQuery)
      ? _productListAccToImei
      : _productListAccToImei
          ?.where((element) => element.name?.toLowerCase().contains(searchQuery!.toLowerCase()) ?? false)
          .toList();

  bool _isShowImeiSearch(List<CategoryData>? categoryList, int? categoryId) {
    var category = categoryList?.firstWhere((element) => element.id == categoryId);
    if (category != null) {
      return category.allowImeiSearch ?? false;
    }
    return false;
  }

  void changeListType({bool isNotify = false}) {
    isShowImeiSearch = false;
    _productListAccToImei = null;
    searchQuery = null;
    if (isNotify) notifyListeners();
  }

  static ProductListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ProductListProvider>(context, listen: listen);
  }

  bool isAllowedVariants() {
    for (CategoryData category in categoryList ?? []) {
      if (category.id == categoryId) {
        return category.allowVariant ?? false;
      }
    }
    return false;
  }

  void getProductsListWithImei() {
    service.getProductListAccToImei(imei).listen((event) {
      if (!Validator.isListNullOrEmpty(event?.productList)) {
        _productListAccToImei = event?.productList;
      } else {
        changeListType();
      }
    }, onError: (error) {
      changeListType();
    }, onDone: () {
      isShowLoading = false;
      notifyListeners();
    });
  }
}
