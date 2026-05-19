import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_category_id_type.dart';
import 'package:imei_serial_reader/imei_serial_reader.dart';
import 'package:provider/provider.dart';

enum BottomButtonState { validation, scanAnother, initDataWipe, cashifyProvider }

class DataWipeDetailProvider extends CshChangeNotifier {
  final String _deviceBarcode;
  DataWipeListItem? data;
  bool isLoading = true;
  bool forceHideInitiateButton = false;
  final int eraserInfoFailedStatus = -11;
  bool _isImeiSerialAlreadyUpdated = false;
  BottomButtonState? _bottomButtonState;
  List<DropDownItem>? _actionList;

  List<DropDownItem>? get actionList => _actionList;

  bool get isImeiSerialAlreadyUpdated => _isImeiSerialAlreadyUpdated;

  DataWipeDetailProvider(this._deviceBarcode) {
    _getActionList();
  }

  bool isProviderCashify() {
    return data?.erasureProviderKey == 0;
  }

  static DataWipeDetailProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<DataWipeDetailProvider>(context, listen: listen);
  }

  BottomButtonState get bottomButtonState => _bottomButtonState ?? BottomButtonState.initDataWipe;

  set bottomButtonState(BottomButtonState value) {
    _bottomButtonState = value;
    notifyListeners();
  }

  void _getActionList() {
    DataWipeService.getSmartWatchActionList().listen((event) {
      if (event != null) {
        _actionList = event.toList()?.map((e) {
          return DropDownItem(e.key, e.label);
        }).toList();
        notifyListeners();
      }
    }, onError: (error) {
      Logger.debug('mydebug-----DataWipeDetailProvider._getActionList', [error]);
    });
  }

  getDeviceWipeStatus({Function(String errorMessage)? onError, bool isFirstTime = false}) {
    DataWipeService.getDataWipeDetails(_deviceBarcode).listen((event) {
      data = event;
      if (isProviderCashify()) {
        _bottomButtonState = BottomButtonState.cashifyProvider;
      } else if (data?.statusCode == eraserInfoFailedStatus) {
        _bottomButtonState = BottomButtonState.validation;
      } else if ((data?.statusCode ?? 0) < 1) {
        _bottomButtonState = BottomButtonState.initDataWipe;
      } else {
        _bottomButtonState = BottomButtonState.scanAnother;
      }
    }, onError: (error) {
      String? errorMessage = ApiErrorHelper.getErrorMessage(error);
      onError?.call(errorMessage.toString());
    }, onDone: () {
      isLoading = false;
      notifyListeners();
    });
  }

  Future<bool> initiateDataWipe() {
    var completer = Completer<bool>();
    DataWipeService.initiateDataWipe(data!.id!).listen((_) {
      getDeviceWipeStatus();
      forceHideInitiateButton = true;
      completer.complete(true);
    }, onError: (error) {
      String? errorMessage = ApiErrorHelper.getErrorMessage(error);
      completer.completeError(errorMessage.toString());
    });
    return completer.future;
  }

  Future<void> reportMisMatch({String? imei1, String? imei2, String? serialNo}) {
    var completer = Completer<void>();
    DataWipeService.reportMisMatch(_deviceBarcode, imei1: imei1, imei2: imei2, serialNo: serialNo).listen((_) {
      _isImeiSerialAlreadyUpdated = true;
      _bottomButtonState = BottomButtonState.initDataWipe;
      completer.complete();
      notifyListeners();
    }, onError: (error) {
      String? errorMessage = ApiErrorHelper.getErrorMessage(error);
      completer.completeError(errorMessage.toString());
    });
    return completer.future;
  }

  Future<void> submitSmartWatchAction({String? action}) {
    var completer = Completer<void>();
    DataWipeService.submitSmartWatchAction(data?.id, action: action).listen((_) {
      completer.complete();
    }, onError: (error) {
      String? errorMessage = ApiErrorHelper.getErrorMessage(error);
      completer.completeError(errorMessage.toString());
    });
    return completer.future;
  }

  ReaderType get readerType =>
      data?.categoryKey == DeviceCategoryIdType.laptop.value ? ReaderType.serialNumberReader : ReaderType.imeiReader;
}
