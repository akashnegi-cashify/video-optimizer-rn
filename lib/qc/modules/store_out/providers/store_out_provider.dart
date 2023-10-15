import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../src/common/searchable.dart';
import '../resources/index.dart';
import '../resources/services.dart';

class StoreOutProvider extends CshChangeNotifier with Searchable {
  bool _showSearchBox = false;
  String? _lotTypeQuery;
  late StreamController<String?> controller;
  late StreamController<String?> searchQueryStreamController;

  late DataState<StoreOutBinListResponse?> binListDataState;

  static StoreOutProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<StoreOutProvider>(context, listen: listen);
  }

  StoreOutProvider() {
    binListDataState = DataState();
    controller = StreamController.broadcast();
    searchQueryStreamController = StreamController.broadcast();
  }

  void fetchStoreOutBinList() {
    binListDataState = binListDataState.copyWith(status: RequestStatus.initial, data: null);
    notifyListeners();
    StoreOutServices.fetchStoreOutBinList().listen((event) {
      binListDataState = binListDataState.copyWith(status: RequestStatus.success, data: event);
      notifyListeners();
    }, onError: (error, stackTrace) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      binListDataState = binListDataState.copyWith(status: RequestStatus.failure, errorMsg: errorMsg,data: null);
      notifyListeners();
    });
  }

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

  void setSearchQuery(String? value ,{bool update = true }){

    searchQuery = value;
    if(update){
      searchQueryStreamController.add(value);
    }

  }

  set lotTypeQuery(String? value) {
    controller.add(value);
    _lotTypeQuery = value;
  }

  bool get showSearchBox => _showSearchBox;

  set showSearchBox(bool value) {
    _showSearchBox = value;
    notifyListeners();
  }

  String? get lotTypeQuery => _lotTypeQuery;

  @override
  void dispose() {
    super.dispose();
    searchQueryStreamController.close();
    controller.close();
  }

  void refreshLotList(){
    _lotTypeQuery = "";
    setSearchQuery("",update: false);
    controller.add("");
  }
}
