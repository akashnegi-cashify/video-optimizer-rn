import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_lot_device_list_response.dart';
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_video_service.dart';
import 'package:flutter_trc/src/common/searchable.dart';
import 'package:provider/provider.dart';

class D2cLotDeviceListingProvider extends CshChangeNotifier with Searchable {
  final String groupLotName;

  D2cLotDeviceListingProvider(this.groupLotName);

  List<D2cLotDeviceListData>? _d2cLotDeviceList;

  static D2cLotDeviceListingProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<D2cLotDeviceListingProvider>(context, listen: listen);
  }

  List<D2cLotDeviceListData>? get d2cLotDeviceList => Validator.isNullOrEmpty(searchQuery)
      ? _d2cLotDeviceList
      : _d2cLotDeviceList
          ?.where((element) => element.deviceBarcode?.toLowerCase().contains(searchQuery!.toLowerCase()) ?? false)
          .toList();

  @override
  set searchQuery(String? value) {
    super.searchQuery = value;
    notifyListeners();
  }

  Future<void> getLotDeviceList() {
    var completer = Completer<void>();
    D2CVideoService.getLotDeviceList(groupLotName).listen(
      (event) {
        _d2cLotDeviceList = event.d2cLotDeviceList;
        completer.complete();
      },
      onError: (error) {
        completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
      },
    );
    return completer.future;
  }

  Future<void> moveLotToNextStatus() {
    var completer = Completer<void>();
    D2CVideoService.updateLotStatus(groupLotName).listen((event) {
      completer.complete();
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });

    return completer.future;
  }
}
