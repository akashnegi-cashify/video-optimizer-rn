import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_out/types.dart';
import 'package:flutter_trc/src/common/provider/qc_trc_service_init_provider.dart';
import 'package:provider/provider.dart';

import '../resources/index.dart';
import '../resources/services.dart';

class StoreOutProvider extends QcTrcServiceInitProvider {
  List<int>? _selectedLotTypeList;

  /// Stream to notify listeners for refreshing store out lot list.
  final StreamController<void> _refreshLotListController = StreamController<void>.broadcast();

  Stream<void> get refreshLotListStream => _refreshLotListController.stream;

  /// Stream to notify listeners for refreshing bin store out lot list.
  final StreamController<void> _refreshBinLotListController = StreamController<void>.broadcast();

  Stream<void> get refreshBinLotListController => _refreshBinLotListController.stream;

  @override
  void dispose() {
    _refreshLotListController.close();
    _refreshBinLotListController.close();
    super.dispose();
  }

  static StoreOutProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<StoreOutProvider>(context, listen: listen);
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

  set selectedLotTypeList(List<int>? value) {
    _selectedLotTypeList = value;
  }

  List<int>? get selectedLotTypeList => _selectedLotTypeList;

  void refreshLotList(int lotType) {
    if (lotType == LotType.NORMAL_LOT.value) {
      if (!_refreshLotListController.isClosed) {
        _refreshLotListController.add(null);
      }
    } else {
      if (!_refreshBinLotListController.isClosed) {
        _refreshBinLotListController.add(null);
      }
    }
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
