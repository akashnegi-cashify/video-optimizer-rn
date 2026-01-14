import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/provider/qc_trc_service_init_provider.dart';
import 'package:provider/provider.dart';

import '../../../../src/common/searchable.dart';
import '../resources/index.dart';
import '../resources/services.dart';

class StoreOutProvider extends QcTrcServiceInitProvider with Searchable {
  bool _showSearchBox = false;
  List<int>? _selectedLotTypeList;
  bool _isStoreOutInProgress = false;

  bool get isStoreOutInProgress => _isStoreOutInProgress;

  set isStoreOutInProgress(bool value) {
    _isStoreOutInProgress = value;
    notifyListeners();
  }

  late DataState<StoreOutBinListResponse?> binListDataState;

  static StoreOutProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<StoreOutProvider>(context, listen: listen);
  }

  @override
  onServiceInitialized() {
    binListDataState = DataState();
  }

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

  void setSearchQuery(String? value) {
    searchQuery = value;
  }

  set selectedLotTypeList(List<int>? value) {
    _selectedLotTypeList = value;
  }

  bool get showSearchBox => _showSearchBox;

  set showSearchBox(bool value) {
    _showSearchBox = value;
    notifyListeners();
  }

  List<int>? get selectedLotTypeList => _selectedLotTypeList;

  void refreshLotList() {
    _selectedLotTypeList?.clear();
    setSearchQuery("");
  }

  Future<bool> getStoreOutProcessStatus(int? lotId, String? groupName) {
    var completer = Completer<bool>();
    StoreOutServices.getStoreOutInProcessStatus(lotId, groupName, service: service).listen((event) {
      completer.complete(event?.storeOutStatus ?? false);
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
