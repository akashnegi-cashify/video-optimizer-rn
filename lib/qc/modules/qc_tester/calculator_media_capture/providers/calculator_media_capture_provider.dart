import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/models/calculator_data_holder_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/media_submit_request.dart';
import 'package:provider/provider.dart';

import '../../calculator/resources/calculator_service.dart';
import '../../calculator/resources/device_media_response.dart';

class CalculatorMediaCaptureProvider extends CalculatorServiceInitProvider {
  DeviceMediaResponse? deviceMediaResponse;
  bool isDataLoading = true;
  String? errorMessage;
  final bool? isComingFromCalJourney;
  final String deviceBarcode;

  CalculatorMediaCaptureProvider(this.deviceBarcode, this.isComingFromCalJourney) : super();

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

  void saveMediaList() {
    CalculatorDataHolderModel().mediaList = deviceMediaResponse?.imageList
        ?.map((e) => MediaSubmitRequest(
            imageName: e.imageName, mediaUrl: e.mediaUrl, isVideo: Validator.isTrue(e.isVideo) ? 1 : 0))
        .toList();
  }

  void getDeviceMedia({VoidCallback? onMoveToNextScreen}) {
    service.getDeviceMedia(deviceBarcode).listen((event) {
      isDataLoading = false;
      if (Validator.isListNullOrEmpty(event?.imageList) && Validator.isTrue(isComingFromCalJourney)) {
        onMoveToNextScreen?.call();
      } else {
        deviceMediaResponse = event;
        notifyListeners();
      }
    }, onError: (error) {
      String msg = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      errorMessage = msg;
      isDataLoading = false;
      notifyListeners();
    });
  }

  Future<bool> submitDeviceMedia() {
    var completer = Completer<bool>();
    service.submitDeviceMedia(CalculatorDataHolderModel().mediaList, deviceBarcode).listen((event) {
      if (event != null) {
        completer.complete(true);
      } else {
        completer.completeError("Something went wrong ${event?.rId}");
      }
    }, onError: (error) {
      Logger.debug('mydebug------CalculatorMediaCaptureProvider.submitDeviceMedia error', [error]);
      String msg = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      completer.completeError(msg);
    });
    return completer.future;
  }
}
