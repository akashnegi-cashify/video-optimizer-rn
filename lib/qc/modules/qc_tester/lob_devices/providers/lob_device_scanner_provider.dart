import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/src/utils/connectivity_util.dart';
import 'package:flutter_trc/src/utils/image_util.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

import '../resources/reasons.dart';

class LobDeviceScannerProvider extends CalculatorServiceInitProvider {
  String? deviceBarcode;
  DeviceDetailResponseData? deviceDetails;
  Map<String, int>? _timeoutReasons;
  Reasons? timeoutSelectedReason;
  bool isLoading = true;

  String? errorMsg;

  LobDeviceScannerProvider(this.deviceBarcode);

  @override
  void onServiceInitialized() {
    getDeviceDetail();
  }

  static LobDeviceScannerProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<LobDeviceScannerProvider>(context, listen: listen);
  }

  List<Reasons> get timeoutReasons => _transformTimeoutReasonsIntoList();

  Future<List<LobProductListData>?> getProductsList(
      String deviceBarcode, String? imei, String? serialNo, bool isManualSearch, int? categoryId) {
    var completer = Completer<List<LobProductListData>?>();
    service.getProductList(deviceBarcode, imei, serialNo, isManualSearch, categoryId).listen((event) {
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

  Future<MyCalculatorResponse?> getLobCalculator(
      String deviceBarcode, int? productMasterId, int? productId, int? categoryId, VariantListData? variantItem) {
    var completer = Completer<MyCalculatorResponse?>();
    service.getLobCalculator(deviceBarcode, productMasterId, productId, categoryId, variantItem).listen((event) {
      completer.complete(event);
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  void getDeviceDetail({String? newDeviceBarcode}) {
    if (!Validator.isNullOrEmpty(newDeviceBarcode)) {
      deviceBarcode = newDeviceBarcode;
      isLoading = true;
      notifyListeners();
    }
    service.getDeviceDetail(deviceBarcode).listen((event) {
      deviceDetails = event?.deviceDetails;
      _timeoutReasons = event?.deviceDetails?.reasons;
      errorMsg = null;
    }, onError: (error) {
      errorMsg = ApiErrorHelper.getErrorMessage(error).toString();
    }, onDone: () {
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> reportMismatch(String imagePath, List<String> scannedImeiList, {bool? isImei2Available}) async {
    var completer = Completer<void>();
    try {
      String imageUrl = await _getCompressedImageUrl(imagePath);
      service
          .reportMismatch(scannedImeiList, deviceBarcode!, imageUrl,
              timeoutReason: timeoutSelectedReason?.name, isImei2Available: isImei2Available)
          .listen((event) {
        timeoutSelectedReason = null;
        completer.complete();
      }, onError: (error) {
        completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
      });
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<String> _getCompressedImageUrl(String imagePath) async {
    var completer = Completer<String>();
    File file = await _getCompressedFile(imagePath);

    _uploadImage(file).then((value) {
      completer.complete(value);
    }, onError: (error) {
      completer.completeError(error);
    });
    return completer.future;
  }

  Future<String> _uploadImage(File file) async {
    var isConnected = await ConnectivityUtil.checkConnectivity();
    if (isConnected == false) {
      return Future.error("No Internet Connection");
    }

    var completer = Completer<String>();
    String fileName = path.basename(file.path);
    MediaUploadUtil().uploadMediaWithType(mediaFile: file, fileName: fileName).then((value) {
      if (value.isNotEmpty) {
        completer.complete(value);
      } else {
        completer.completeError("Something went wrong");
      }
    }, onError: (error) {
      completer.completeError(error);
    });
    return completer.future;
  }

  Future<File> _getCompressedFile(String filePath) async {
    File compressedFile = await ImageUtil.compressImage(File(filePath));
    return compressedFile;
  }

  List<Reasons> _transformTimeoutReasonsIntoList() {
    List<Reasons> reasonList = [];
    _timeoutReasons?.keys.forEach((element) {
      reasonList.add(Reasons(element, _timeoutReasons![element]!));
    });
    return reasonList;
  }

  void updateReason(Reasons? reason) {
    timeoutSelectedReason = reason;
  }

  Future<String> updateImei(String filePath, String? updatedImei, bool? isImeiAvailable,
      {bool isAutoApproved = false}) async {
    var completer = Completer<String>();
    try {
      String imageUrl = await _getCompressedImageUrl(filePath);
      service
          .reportMismatch(
        !Validator.isNullOrEmpty(updatedImei) ? [updatedImei] : null,
        deviceBarcode!,
        imageUrl,
        timeoutReason: timeoutSelectedReason?.name,
        isImei2Available: isImeiAvailable,
        isAutoApproved: isAutoApproved,
      )
          .listen((event) {
        timeoutSelectedReason = null;
        completer.complete("Imei Updated Successfully");
      }, onError: (error) {
        completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
      });
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  bool isAllowedVariants(int selectedCategoryId) {
    for (CategoryData category in deviceDetails?.categoryList ?? []) {
      if (category.id == selectedCategoryId) {
        return category.allowVariant ?? false;
      }
    }
    return false;
  }

  Future<List<VariantListData>> getVariantList(int? productId) {
    var completer = Completer<List<VariantListData>>();
    service.getVariantList(productId).listen((event) {
      if (!Validator.isListNullOrEmpty(event?.variantListResponseData)) {
        completer.complete(event?.variantListResponseData);
      } else {
        completer.completeError("No variant found for this product");
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
