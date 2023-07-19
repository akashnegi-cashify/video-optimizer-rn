import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/models/calculator_data_holder_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/media_submit_request.dart';
import 'package:provider/provider.dart';

import '../../calculator/resources/calculator_service.dart';
import '../../calculator/resources/device_media_response.dart';

class CalculatorMediaCaptureProvider extends CshChangeNotifier {
  DeviceMediaResponse? deviceMediaResponse;
  bool isDataLoading = true;
  String? errorMessage;

  bool isAllMediaUpLoaded() {
    if (Validator.isListNullOrEmpty(deviceMediaResponse?.imageList)) {
      return false;
    }

    var index = deviceMediaResponse!.imageList!.indexWhere((element) => Validator.isNullOrEmpty(element.mediaUrl));
    if (index != -1) {
      return false;
    }

    return true;
  }

  static CalculatorMediaCaptureProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CalculatorMediaCaptureProvider>(context, listen: listen);
  }

  CalculatorMediaCaptureProvider() {
    _getDeviceMedia();
  }

  void saveMediaList() {
    CalculatorDataHolderModel().mediaList = deviceMediaResponse?.imageList
        ?.map((e) => MediaSubmitRequest(
            imageName: e.imageName, mediaUrl: e.mediaUrl, isVideo: Validator.isTrue(e.isVideo) ? 1 : 0))
        .toList();
  }

  _getDeviceMedia() {
    CalculatorService.getDeviceMedia(CalculatorDataHolderModel().deviceBarcode ?? "").listen((event) {
      if (event != null) {
        deviceMediaResponse = event;
      }
    }, onError: (error) {
      String msg = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------CalculatorMediaCaptureProvider._getDeviceMedia', [msg]);
      errorMessage = msg;
    }, onDone: () {
      isDataLoading = false;
      notifyListeners();
    });
  }
}
