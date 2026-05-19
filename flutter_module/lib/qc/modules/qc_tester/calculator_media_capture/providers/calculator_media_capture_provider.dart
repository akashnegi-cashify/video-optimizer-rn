import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/models/calculator_data_holder_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/media_submit_request.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_quote_request_data.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator_media_capture/resources/journey_type.dart';
import 'package:provider/provider.dart';

import '../../calculator/resources/calculator_service.dart';
import '../../calculator/resources/device_media_response.dart';

class CalculatorMediaCaptureProvider extends CalculatorServiceInitProvider {
  DeviceMediaResponse? deviceMediaResponse;
  bool isDataLoading = true;
  String? errorMessage;
  final JourneyType? journeyType;
  final String deviceBarcode;
  final int? categoryId;

  CalculatorMediaCaptureProvider(this.deviceBarcode, this.journeyType, {this.categoryId}) : super();

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

  List<MediaSubmitRequest>? get uploadedMediaList => CalculatorDataHolderModel().mediaList;

  void saveMediaList() {
    CalculatorDataHolderModel().mediaList = deviceMediaResponse?.imageList
        ?.map((e) => MediaSubmitRequest(
            imageName: e.imageName, mediaUrl: e.mediaUrl, isVideo: Validator.isTrue(e.isVideo) ? 1 : 0))
        .toList();
  }

  void getDeviceMedia({VoidCallback? onMoveToNextScreen}) {
    MyQuoteRequestData? quoteRequestData;
    if (journeyType == JourneyType.testing) {
      quoteRequestData = CalculatorDataHolderModel().quoteRequestData;
    }

    service.getDeviceMedia(deviceBarcode, categoryId: categoryId, quoteRequest: quoteRequestData).listen((event) {
      isDataLoading = false;
      if (Validator.isListNullOrEmpty(event?.imageList) && journeyType == JourneyType.testing) {
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
    service.submitDeviceMedia(uploadedMediaList, deviceBarcode).listen((event) {
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
