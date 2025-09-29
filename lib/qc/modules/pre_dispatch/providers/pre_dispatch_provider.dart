import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../resources/index.dart';
import '../resources/services.dart';
import '../types.dart';

class PreDispatchProvider extends CshChangeNotifier {
  late DataState<PreDispatchItemResponse?> dataState;
  final String groupLotName;
  ScanPreDispatchResponse? scanPreDispatchResponse;

  static PreDispatchProvider of({required BuildContext context, bool listen = true}) {
    return Provider.of<PreDispatchProvider>(context, listen: listen);
  }

  PreDispatchProvider(this.groupLotName) {
    dataState = DataState();
    fetchPreDispatchItemDetail();
  }

  Future<PreDispatchItemResponse?> fetchPreDispatchItemDetail() {
    dataState = dataState.copyWith(data: null, status: RequestStatus.initial);
    notifyListeners();
    var completer = Completer<PreDispatchItemResponse?>();
    DispatchLotServices.fetchPreDispatchItemDetail(groupLotName).listen((event) {
      dataState = dataState.copyWith(data: event, status: RequestStatus.success);
      completer.complete(event);
      notifyListeners();
    }, onError: (error, stack) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong";
      dataState = dataState.copyWith(errorMsg: errorMsg, status: RequestStatus.failure, data: null);
      completer.completeError(errorMsg);
      Logger.debug('PreDispatchProvider.fetchPreDispatchItemDetail', [errorMsg]);
      notifyListeners();
    });
    return completer.future;
  }

  List<PreDispatchItem?>? getItemsBasedOnStatus(int? status) {
    if (status == null) return dataState.data?.items;
    return dataState.data?.items?.where((element) => element?.status == status).toList();
  }

  void refreshData() {
     fetchPreDispatchItemDetail();
  }

  Future<ScanPreDispatchResponse?> scanPreDispatchLot(String qrCode) {
    var completer = Completer<ScanPreDispatchResponse?>();
    var request = ScanPreDispatchRequest(lotGroupName: groupLotName, qrCode: qrCode);
    DispatchLotServices.scanPreLotDispatch(request).listen((event) {
      scanPreDispatchResponse = event;
      var item = ArrayUtil.firstWhere<PreDispatchItem?>(
        dataState.data?.items ?? [],
            (element) => element?.qrCode == qrCode,
      );

      item?.status = DispatchConstants.SCANNED_STATUS;
      scanPreDispatchResponse?.preDispatchItem = item;

      completer.complete(event);
      notifyListeners();
    }, onError: (error, stack) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong";
      completer.completeError(errorMsg);
      Logger.debug('PreDispatchProvider.scanPreDispatchLot', [errorMsg]);
      notifyListeners();
    });
    return completer.future;
  }


  Future<CompletePreDispatchResponse?> completePreDispatchLot() {
    var completer = Completer<CompletePreDispatchResponse?>();
    DispatchLotServices.completePreLotDispatch(groupLotName).listen((event) {
      completer.complete(event);
      notifyListeners();
    }, onError: (error, stack) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong";
      completer.completeError(errorMsg);
      Logger.debug('PreDispatchProvider.scanPreDispatchLot', [errorMsg]);
      notifyListeners();
    });
    return completer.future;
  }


  bool scanCode() {
    return getItemsBasedOnStatus(DispatchConstants.PENDING_STATUS)?.isNotEmpty == true;
  }

  bool isAllItemScan(){
    return dataState.data?.items?.every((element) => element?.status == DispatchConstants.SCANNED_STATUS) ?? false;
  }



}
