import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/assigned_device_details.dart';
import 'package:provider/provider.dart';

class WIPDeviceDetailProvider extends CshChangeNotifier {
  static WIPDeviceDetailProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<WIPDeviceDetailProvider>(context, listen: listen);
  }

  AssignDeviceDetailsData? _deviceInfo;

  AssignDeviceDetailsData? get deviceInfo => _deviceInfo;

  String deviceBarcode;

  WIPDeviceDetailProvider(this.deviceBarcode) {
    getDeviceDetails();
  }

  getDeviceDetails() {
    EngineerAPIService.getDeviceDetails(deviceBarcode).listen((event) {
      if (event?.detailsData != null) {
        _deviceInfo = event?.detailsData;
        notifyListeners();
      }
    }, onError: (error) {
      var errorMassage = ApiErrorHelper.getErrorMessage(error);
    });
  }

  bool? isScrewImagesUploaded() {
    return _deviceInfo?.isScrewMediaUploaded;
  }
}
