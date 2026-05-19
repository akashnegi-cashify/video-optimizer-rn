import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_out/types.dart';
import 'package:flutter_trc/src/common/provider/qc_trc_service_init_provider.dart';
import 'package:provider/provider.dart';

import '../resources/index.dart';
import '../resources/services.dart';

class LotScanProvider extends QcTrcServiceInitProvider {
  final int? lotId;
  final String? lotName; // Keep for display purposes
  final int lotType;

  int _scanItemPosition = 0;

  late DataState<List<ScanNormalLotItem>?> dataState;
  late DataState<ScanBinLotListResponse?> binDataState;

  static LotScanProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<LotScanProvider>(context, listen: listen);
  }

  LotScanProvider({required this.lotId, this.lotName, required this.lotType}) {
    if (LotType.fromValue(lotType) == LotType.NORMAL_LOT) {
      dataState = DataState();
    } else {
      binDataState = DataState();
    }
  }

  @override
  void onServiceInitialized() {
    if (LotType.fromValue(lotType) == LotType.NORMAL_LOT) {
      fetchNormalLotScanList();
    } else {
      fetchBinLotScanList();
    }
  }

  void fetchNormalLotScanList() {
    StoreOutServices.fetchNormalScanLotList(lotId, lotType, service: service).listen((event) {
      if (Validator.isListNullOrEmpty(event)) {
        dataState = dataState.copyWith(
            data: null,
            status: RequestStatus.failure,
            errorMsg: "All devices store-out done!\nPlease refresh lot list for update info.");
      } else {
        dataState = dataState.copyWith(data: event, status: RequestStatus.success);
      }
      notifyListeners();
    }, onError: (error, stackTrace) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      dataState = dataState.copyWith(data: null, status: RequestStatus.failure, errorMsg: errorMsg);
      notifyListeners();
      Logger.debug('LotScanProvider.fetchScanListItems', [errorMsg]);
    });
  }

  void fetchBinLotScanList() {
    StoreOutServices.fetchBinScanLotList(lotName ?? "", lotType, service: service).listen((event) {
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

  Future<void> binOutVerifyBarCode(BinOutRequest request) {
    var completer = Completer<BinOutVerifyResponse?>();

    StoreOutServices.binOutVerifyBarCodeService(request, service: service).listen((event) {
        completer.complete();
    }, onError: (error, stackTrace) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      completer.completeError(errorMsg);
    });

    return completer.future;
  }

  Future<NormalLotVerifyResponse?> normalLotOutVerifyBarCode(NormalLotOutRequest request) {
    var completer = Completer<NormalLotVerifyResponse?>();

    StoreOutServices.normalLotVerifyBarCodeService(
            lotId: request.lotId ?? lotId,
            qrCode: request.stockBarcode ?? "",
            displayBarcode: request.locBarcode ?? "",
            service: service)
        .listen((event) {
      completer.complete();
    }, onError: (error, stackTrace) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      completer.completeError(errorMsg);
    });

    return completer.future;
  }

  bool moveNext() {
    var value = false;

    var itemLen =
        lotType == LotType.NORMAL_LOT.value ? (dataState.data?.length ?? 0) : (binDataState.data?.lotList?.length ?? 0);
    itemLen = itemLen - 1;
    if (_scanItemPosition < itemLen) {
      value = true;
    } else {
      value = false;
    }
    _scanItemPosition++;
    notifyListeners();
    return value;
  }
}
