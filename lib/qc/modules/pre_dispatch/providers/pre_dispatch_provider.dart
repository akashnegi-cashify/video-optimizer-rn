import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/lot_device_list_response.dart';
import 'package:flutter_trc/qc/modules/re_qc/resources/re_qc_service.dart';
import 'package:provider/provider.dart';

import '../resources/index.dart';
import '../resources/services.dart';
import '../types.dart';

class PreDispatchProvider extends CshChangeNotifier {
  late DataState<LotDeviceListResponse?> dataState;
  final String groupLotName;
  final int lotId;
  ScanPreDispatchResponse? scanPreDispatchResponse;

  static PreDispatchProvider of({required BuildContext context, bool listen = true}) {
    return Provider.of<PreDispatchProvider>(context, listen: listen);
  }

  PreDispatchProvider(this.groupLotName, this.lotId) {
    dataState = DataState();
    getLotDeviceList();
  }

  Future<LotDeviceListResponse?> getLotDeviceList() {
    dataState = dataState.copyWith(data: null, status: RequestStatus.initial);
    notifyListeners();
    var completer = Completer<LotDeviceListResponse?>();
    ReQcService.getLotDeviceList(lotId).listen((event) {
      dataState = dataState.copyWith(data: event, status: RequestStatus.success);
      completer.complete(event);
      notifyListeners();
    }, onError: (error, stack) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong";
      dataState = dataState.copyWith(errorMsg: errorMsg, status: RequestStatus.failure, data: null);
      completer.completeError(errorMsg);
      Logger.debug('PreDispatchProvider.getLotDeviceList', [errorMsg]);
      notifyListeners();
    });
    return completer.future;
  }

  List<LotDeviceListData?>? getItemsBasedOnStatus(int? status) {
    if (status == null) return dataState.data?.deviceList;
    return dataState.data?.deviceList?.where((element) => element?.status == status).toList();
  }

  void refreshData() {
     getLotDeviceList();
  }

  Future<ScanPreDispatchResponse?> scanPreDispatchLot(String qrCode) {
    var completer = Completer<ScanPreDispatchResponse?>();
    var request = ScanPreDispatchRequest(lotGroupName: groupLotName, qrCode: qrCode);
    DispatchLotServices.scanPreLotDispatch(request).listen((event) {
      scanPreDispatchResponse = event;
      var item = ArrayUtil.firstWhere<LotDeviceListData?>(
        dataState.data?.deviceList ?? [],
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
    return dataState.data?.deviceList?.every((element) => element?.status == DispatchConstants.SCANNED_STATUS) ?? false;
  }



}
