import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/common_resources/elss_service.dart';
import 'package:provider/provider.dart';

import '../../common_models/brands_all_products.dart';
import '../../common_models/brands_listing_models.dart';
import '../../common_models/products_colour_response.dart';

class BrandsListingProvider extends CshChangeNotifier {
  static BrandsListingProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<BrandsListingProvider>(context, listen: listen);
  }

  BrandsListingProvider(String barcode) {
    scannedBarcode = barcode;
    _getBrandDetailsListingData();
  }

  bool isDataLoading = true;
  String scannedBarcode = "";
  BrandsListingResponse? brandDetailsData;
  BrandsAllProductResponse? brandsAllProductResponse;
  ProductsColorResponse? productsColorResponse;

  _getBrandDetailsListingData() {
    ElssService.getBrandsData().listen((event) {
      if (event != null) {
        brandDetailsData = event;
      }
    }, onError: (error) {
      String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong";
      Logger.debug('mydebug------BrandsListingProvider._getBrandDetailsListingData', [errorMessage]);
    }, onDone: () {
      isDataLoading = false;
      notifyListeners();
    });
  }

  Future<bool> fetchProductsFromBid(int brandId) {
    var completer = Completer<bool>();
    try {
      ElssService.getBrandsAllProducts(brandId).listen((event) {
        if (event != null) {
          brandsAllProductResponse = event;
          completer.complete(true);
        } else {
          completer.complete(false);
        }
      }, onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong!!";
        Logger.debug('mydebug------BrandsListingProvider.fetchProductsFromBid', [errorMessage]);
        completer.completeError(errorMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<bool> fetchProductColorByPid(int pid) {
    var completer = Completer<bool>();
    try {
      ElssService.getProductsColoursData(pid).listen((event) {
        if (event != null) {
          productsColorResponse = event;
          completer.complete(true);
        } else {
          completer.complete(false);
        }
      }, onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------BrandsListingProvider.fetchProductColorByPid', [errorMessage]);
        completer.completeError(errorMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<bool> submitDeviceDetails(String barcode, int brandId, int productId, {String? color}) {
    var completer = Completer<bool>();
    try {
      ElssService.submitDeviceDetails(brandId, productId, barcode, color: color).listen((event) {
        if (event != null) {
          completer.complete(true);
        } else {
          completer.complete(false);
        }
      }, onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong";
        completer.completeError(errorMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  resetProductsColors() {
    brandsAllProductResponse = null;
    productsColorResponse = null;
    notifyListeners();
  }

  resetColors() {
    productsColorResponse = null;
    notifyListeners();
  }

  getBrandDropDownItems(List<BrandsDataModel> dataList) {
    return List.generate(
      dataList.length,
      (index) => DropDownItem(dataList[index].brandId.toString(), dataList[index].brandName),
    );
  }

  getProductDropDownItems(List<BrandsAllProductDataList> dataList) {
    return List.generate(
      dataList.length,
      (index) => DropDownItem(dataList[index].pid.toString(), dataList[index].productName),
    );
  }

  getProductColorDropDownItems(List<String>? dataList) {
    return List.generate(
      dataList?.length ?? 0,
      (index) => DropDownItem(index.toString(), dataList?[index]),
    );
  }
}
