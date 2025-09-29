import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_in/resources/services.dart';
import 'package:flutter_trc/src/common/provider/qc_trc_service_init_provider.dart';
import 'package:provider/provider.dart';

import '../resources/index.dart';

class StoreInProvider extends QcTrcServiceInitProvider {
  String? locQrCode;
  int? availableSpace;
  int? totalCount;
  final bool isBinStoreIn;

  bool isScreenLoading = true;
  String? errorMessage;

  static StoreInProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<StoreInProvider>(context, listen: listen);
  }

  StoreInProvider({this.locQrCode, required this.isBinStoreIn});

  @override
  void onServiceInitialized() {
    verifyStoreInDetails();
  }

  void verifyStoreInDetails() {
    StoreInServices.verifyLocBarCode(locQrCode, isBinStoreIn, service: service).listen((event) {
      if (event?.isValid() == true) {
        totalCount = event?.totalSpace;
        availableSpace = event?.availableSpace;
        errorMessage = null;
      } else {
        errorMessage = 'Error In Location Tagged To Device.';
      }
    }, onError: (error, stackTrace) {
      errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      Logger.debug('StoreInProvider.verifyStoreInDetails', [errorMessage]);
    }, onDone: () {
      isScreenLoading = false;
      notifyListeners();
    });
  }

  Future<StoreInLocationVerifyResponse?> storeInDevice(String deviceBarCode) {
    var completer = Completer<StoreInLocationVerifyResponse?>();
    StoreInServices.storeInDevice(
      StoreInDeviceRequest(stockBarcode: deviceBarCode, locBarcode: locQrCode),
      isBinStoreIn,
      service: service,
    ).listen((event) {
      if (event?.isValid() == true) {
        totalCount = event?.totalSpace;
        availableSpace = event?.availableSpace;
        completer.complete(event);
      } else {
        completer.completeError('Error In Location Tagged To Device.');
      }
    }, onError: (error, stackTrace) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      Logger.debug('StoreInProvider.storeInDevice', [errorMsg]);
      completer.completeError(errorMsg);
    }, onDone: () {
      notifyListeners();
    });

    return completer.future;
  }
}
