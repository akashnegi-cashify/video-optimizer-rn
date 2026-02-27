import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/lot_device_list_response.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/tl_list_response.dart';
import 'package:flutter_trc/src/modules/trc_executive/resources/device_scanner_service.dart';
import 'package:provider/provider.dart';

class TrcExecutiveStoreOutProvider extends CshChangeNotifier {
  TlListData tlData;
  final String? lotName;

  List<LotDevice> _deviceList = [];
  bool isLoadingDevices = true;

  TrcExecutiveStoreOutProvider(this.tlData, {this.lotName}) {
    if (lotName != null) {
      fetchDeviceList();
    } else {
      isLoadingDevices = false;
    }
  }

  static TrcExecutiveStoreOutProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<TrcExecutiveStoreOutProvider>(context, listen: listen);
  }

  String? get tlName => tlData.name;

  void selectTl(TlListData newTl) {
    tlData = newTl;
    notifyListeners();
  }

  LotDevice? get currentDevice => _deviceList.isEmpty ? null : _deviceList.first;

  void fetchDeviceList() {
    if (lotName == null) return;
    isLoadingDevices = true;
    notifyListeners();
    DeviceScannerService.getLotDeviceList(lotName!).listen(
      (LotDeviceListResponse? response) {
        _deviceList = response?.data?.whereType<LotDevice>().toList() ?? [];
        isLoadingDevices = false;
        notifyListeners();
      },
      onError: (error) {
        isLoadingDevices = false;
        notifyListeners();
      },
    );
  }

  Future<void> validateAndStoreOut(String scannedBarcode) {
    if (currentDevice != null && scannedBarcode.toLowerCase() != currentDevice!.barcode?.toLowerCase()) {
      return Future.error('Scanned barcode does not match expected device');
    }
    return storeOut(scannedBarcode).then((_) {
      if (_deviceList.isNotEmpty) {
        _deviceList.removeAt(0);
        notifyListeners();
      }
    });
  }

  Future<void> storeOut(String barcode) {
    var completer = Completer<void>();
    int tlId = tlData.id ?? -1;
    DeviceScannerService.storeOut(barcode, tlId).listen((event) {
      completer.complete();
    }, onError: (error) {
      var message = ApiErrorHelper.getErrorMessage(error);
      completer.completeError(message.toString());
    });
    return completer.future;
  }
}
