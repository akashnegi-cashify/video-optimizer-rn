import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common_models/elss_device_details_response.dart';
import '../../common_resources/elss_service.dart';

class ElssStatusProvider extends CshChangeNotifier {
  static ElssStatusProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ElssStatusProvider>(context, listen: listen);
  }

  ElssStatusProvider(String barcode) {
    _fetchDeviceDetails(barcode);
  }

  ElssDeviceDetailsResponse? elssDeviceDetailsResponse;
  bool isDataLoading = true;
  String? errMessage;

  _fetchDeviceDetails(String barcode) {
    ElssService.getElssStatusDeviceDetails(barcode).listen((event) {
      if (event != null) {
        elssDeviceDetailsResponse = event;
      }
    }, onError: (error) {
      String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------ElssStatusProvider._fetchDeviceDetails', [errorMessage]);
      errMessage = errorMessage;
    }, onDone: () {
      isDataLoading = false;
      notifyListeners();
    });
  }
}
