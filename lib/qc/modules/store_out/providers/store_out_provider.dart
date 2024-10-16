import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/provider/qc_trc_service_init_provider.dart';
import 'package:flutter_trc/src/common/resources/lot_list_request.dart';
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

  Future<List<StoreOutLotListItem>?> fetchStoreOutList(int pageNo, int offset) {
    var completer = Completer<List<StoreOutLotListItem>?>();
    LotListRequest request = LotListRequest(
      pageNo: pageNo,
      pageSize: offset,
      filterMap: FilterMap(
          searchQuery: searchQuery,
          isStoreOut: _isStoreOutInProgress ? 1 : 0,
          lotType: Validator.isListNullOrEmpty(_selectedLotTypeList) ? null : _selectedLotTypeList),
    );
    StoreOutServices.fetchStoreOutLotList(request, service: service).listen(
      (event) {
        if (!Validator.isListNullOrEmpty(event?.lotList)) {
          completer.complete(event?.lotList);
        } else {
          completer.completeError("No data found");
        }
      },
      onError: (error) {
        completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
      },
    );
    return completer.future;
  }

  void fetchStoreOutBinList() {
    binListDataState = binListDataState.copyWith(status: RequestStatus.initial, data: null);
    notifyListeners();
    StoreOutServices.fetchStoreOutBinList(service: service).listen((event) {
      binListDataState = binListDataState.copyWith(status: RequestStatus.success, data: event);
      notifyListeners();
    }, onError: (error, stackTrace) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      binListDataState = binListDataState.copyWith(status: RequestStatus.failure, errorMsg: errorMsg, data: null);
      notifyListeners();
    });
  }

  Future<void> binOutVerifyBarCode(BinOutRequest request) {
    var completer = Completer<BinOutVerifyResponse?>();

    StoreOutServices.binOutVerifyBarCodeService(request, service: service).listen((event) {
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

  Future<bool> getStoreOutProcessStatus(int? lotId) {
    var completer = Completer<bool>();
    StoreOutServices.getStoreOutInProcessStatus(lotId, service: service).listen((event) {
      completer.complete(event?.storeOutInProcessData?.isStoreOutInProcess ?? false);
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
