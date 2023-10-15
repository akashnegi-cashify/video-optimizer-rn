import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_out/types.dart';
import 'package:provider/provider.dart';

import '../resources/index.dart';
import '../resources/services.dart';

class LotScanProvider extends CshChangeNotifier {
  final String lotName;
  final int lotType;

  int _scanItemPosition = 0;

  late DataState<ScanNormalLotListResponse?> dataState;
  late DataState<ScanBinLotListResponse?> binDataState;

  static LotScanProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<LotScanProvider>(context, listen: listen);
  }

  LotScanProvider.normalLotList({required this.lotName, required this.lotType}) {
    print('LotScanProvider.lotList :::: ');
    dataState = DataState();
    fetchNormalLotScanList();
  }

  LotScanProvider.binLotList({required this.lotName, required this.lotType}) {
    print('LotScanProvider.binLotList :::: ');
    binDataState = DataState();
    fetchBinLotScanList();
  }

  void fetchNormalLotScanList() {
    StoreOutServices.fetchNormalScanLotList(lotName, lotType).listen((event) {
      dataState = dataState.copyWith(data: event, status: RequestStatus.success);
      notifyListeners();
    }, onError: (error, stackTrace) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      dataState = dataState.copyWith(data: null, status: RequestStatus.failure, errorMsg: errorMsg);
      notifyListeners();
      Logger.debug('LotScanProvider.fetchScanListItems', [errorMsg]);
    });
  }

  void fetchBinLotScanList() {
    StoreOutServices.fetchBinScanLotList(lotName, lotType).listen((event) {
      binDataState = binDataState.copyWith(data: event, status: RequestStatus.success);
      notifyListeners();
    }, onError: (error, stackTrace) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      binDataState = binDataState.copyWith(data: null, status: RequestStatus.failure, errorMsg: errorMsg);
      notifyListeners();
      Logger.debug('LotScanProvider.fetchScanListItems', [errorMsg]);
    });
  }

  int get scanPosition => _scanItemPosition;

  Future<BinOutVerifyResponse?> binOutVerifyBarCode(BinOutRequest request) {
    var completer = Completer<BinOutVerifyResponse?>();

    StoreOutServices.binOutVerifyBarCodeService(request).listen((event) {
      if (event?.isValid() == true) {
        completer.complete();
      } else {
        completer.completeError(event?.message ?? "Something Went Wrong.");
      }
    }, onError: (error, stackTrace) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      completer.completeError(errorMsg);
    });

    return completer.future;
  }


  Future<NormalLotVerifyResponse?> normalLotOutVerifyBarCode(NormalLotOutRequest request) {
    var completer = Completer<NormalLotVerifyResponse?>();

    StoreOutServices.normalLotVerifyBarCodeService(request).listen((event) {
      print('LotScanProvider.normalLotOutVerifyBarCode ::::: ${event?.status}');

      if (event?.isValid() == true) {
        completer.complete();
      } else {
        completer.completeError(event?.message ?? "Something Went Wrong.");
      }
    }, onError: (error, stackTrace) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      completer.completeError(errorMsg);
    });

    return completer.future;
  }


  bool moveNext() {
    var value = false;

    var itemLen = lotType == LotType.NORMAL_LOT.value
        ? (dataState.data?.lotList?.length ?? 0)
        : (binDataState.data?.lotList?.length ?? 0);
    itemLen = itemLen-1;
    if (_scanItemPosition < itemLen) {
      value = true;
      _scanItemPosition++;
    }
    else{
      value = false;
    }
    notifyListeners();
    return value;
  }
}
