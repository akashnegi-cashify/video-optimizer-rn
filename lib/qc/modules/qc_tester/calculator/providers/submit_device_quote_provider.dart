import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/models/calculator_data_holder_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_status_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/manual_question_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/media_submit_request.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_quote_request_data.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/widgets/submit_device_quote_widget.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/events/additional_questions_selected_event.dart';
import 'package:provider/provider.dart';

class SubmitDeviceQuoteProvider extends CalculatorServiceInitProvider {
  late final MyQuoteRequestData? quoteRequest;
  late final List<MediaSubmitRequest>? mediaList;
  late final String? deviceBarcode;
  late final bool isDeviceTypeLob;
  VariantListData? _variantData;
  SubmitDeviceQuoteInterface? iDeviceQuote;
  bool isShowCompleteState = false;
  bool isShowTryAgainState = false;
  bool isCaptureQcImages = false;
  List<ManualQuestionListData>? _questionList;
  String? gradeObtained;

  List<StepDetails> stepperDetails = [
    StepDetails(title: "Requesting Colors", subTitle: "Please wait...", content: const SizedBox.shrink())
  ];

  static SubmitDeviceQuoteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<SubmitDeviceQuoteProvider>(context, listen: listen);
  }

  SubmitDeviceQuoteProvider() : super() {
    quoteRequest = CalculatorDataHolderModel().quoteRequestData;
    mediaList = CalculatorDataHolderModel().mediaList;
    deviceBarcode = CalculatorDataHolderModel().deviceBarcode;
    isDeviceTypeLob = CalculatorDataHolderModel().isDeviceTypeLob();
    _variantData = CalculatorDataHolderModel().variantData;
  }

  setDeviceQuoteInterface(SubmitDeviceQuoteInterface value) {
    iDeviceQuote = value;
  }

  void getDeviceColors() {
    iDeviceQuote?.showLoading(true);
    service.getDeviceColors(quoteRequest?.productId).listen((event) {
      iDeviceQuote?.showLoading(false);
      if (!Validator.isListNullOrEmpty(event?.deviceColorList)) {
        iDeviceQuote?.onDeviceColorFetchedSuccess(event!.deviceColorList!);
      } else {
        var stepperItem = stepperDetails.last;
        stepperItem.title = "Color Error";
        stepperItem.subTitle = "No color found";
        iDeviceQuote?.onSubmitCalculatorError("No Color Found");
        // _submitCalculatorRequest();
      }
    }, onError: (error) {
      iDeviceQuote?.showLoading(false);
      var errorMessage = ApiErrorHelper.getErrorMessage(error);
      var stepperItem = stepperDetails.last;
      stepperItem.title = "Color Error";
      stepperItem.subTitle = errorMessage.toString();
      iDeviceQuote?.onSubmitCalculatorError(errorMessage ?? "No Color Found");
      // _submitCalculatorRequest();
    }, onDone: () {
      notifyListeners();
    });
  }

  _submitCalculatorRequest({String? testingRemarks}) {
    stepperDetails.add(
      StepDetails(
        title: "Requesting Quotes",
        subTitle: "Please wait...",
        content: const SizedBox.shrink(),
      ),
    );
    notifyListeners();
    iDeviceQuote?.showLoading(true);
    if (!Validator.isNullOrEmpty(testingRemarks)) {
      quoteRequest?.testingRemarks = testingRemarks;
    }
    if (_variantData != null) {
      quoteRequest?.variantId = _variantData?.id;
      quoteRequest?.variantName = _variantData?.name;
    }
    service.submitCalculatorResponse(quoteRequest, deviceBarcode, isDeviceTypeLob: isDeviceTypeLob).listen((event) {
      iDeviceQuote?.showLoading(false);
      var stepperItem = stepperDetails.last;
      stepperItem.title = "Quote Obtained : Grade is";
      stepperItem.subTitle = event?.grade ?? "";
      gradeObtained = event?.grade;
      iDeviceQuote?.onSubmitCalculatorSuccess(event?.grade, event?.cautionMessage);
      _submitManualQuestions();
      if (Validator.isListNullOrEmpty(mediaList)) {
        _proceedAfterImageSubmission();
      } else {
        _submitDeviceImages();
      }
    }, onError: (error) {
      var errorMessage = ApiErrorHelper.getErrorMessage(error);
      var stepperItem = stepperDetails.last;
      stepperItem.title = "Quote Error";
      stepperItem.subTitle = errorMessage.toString();
      iDeviceQuote?.showLoading(false);
      iDeviceQuote?.onSubmitCalculatorError(errorMessage);
    }, onDone: () {
      notifyListeners();
    });
  }

  onColorSelected(String selectedColor) {
    var stepperItem = stepperDetails.last;
    stepperItem.title = "Selected Color";
    stepperItem.subTitle = selectedColor;
    notifyListeners();
    quoteRequest?.selectedColor = selectedColor;
    isLoginFromQC().then((value) {
      if (Validator.isTrue(value)) {
        _submitCalculatorRequest();
      } else {
        iDeviceQuote?.showTrcRemarksDialog();
      }
    });
  }

  void _submitDeviceImages() {
    iDeviceQuote?.showLoading(true);
    service.submitDeviceMedia(mediaList, deviceBarcode).listen((event) {}, onDone: () {
      iDeviceQuote?.showLoading(false);
      _proceedAfterImageSubmission();
    });
  }

  void _proceedAfterImageSubmission() {
    stepperDetails.add(
      StepDetails(
        title: "Channel Request",
        subTitle: "Please wait...",
        content: const SizedBox.shrink(),
      ),
    );
    notifyListeners();
    Future.delayed(const Duration(seconds: 1), () => getDeviceStatus());
  }

  Future<void> getDeviceStatus() async {
    String? errorMessage;
    iDeviceQuote?.showLoading(true);
    for (int i = 0; i < 5; i++) {
      try {
        var deviceStatusResponse = await _callingDeviceStatusApi();
        if (deviceStatusResponse == null) {
          await Future.delayed(const Duration(seconds: 4));
          continue;
        }

        if (Validator.isNullOrEmpty(deviceStatusResponse.trcStatus) &&
            Validator.isListNullOrEmpty(deviceStatusResponse.salesChannels)) {
          await Future.delayed(const Duration(seconds: 4));
          continue;
        }

        var stepperItem = stepperDetails.last;
        stepperItem.title = "Channel";

        String subTitle = deviceStatusResponse.stockAge != null ? "Stock Age - ${deviceStatusResponse.stockAge}, " : "";

        if (!Validator.isNullOrEmpty(deviceStatusResponse.trcStatus)) {
          stepperItem.subTitle = subTitle + deviceStatusResponse.trcStatus!;
        } else {
          stepperItem.subTitle = subTitle + deviceStatusResponse.salesChannels!.join(",");
        }
        isShowCompleteState = true;
        isCaptureQcImages = deviceStatusResponse.isCaptureQcImages ?? false;
        errorMessage = null;
        break;
      } catch (e) {
        errorMessage = ApiErrorHelper.getErrorMessage(e);
        continue;
      }
    }
    iDeviceQuote?.showLoading(false);
    iDeviceQuote?.removeAllLoader();
    isShowTryAgainState = !isShowCompleteState;
    if (!isShowCompleteState) {
      var stepperItem = stepperDetails.last;
      stepperItem.title = "Channel Error";
      stepperItem.subTitle = errorMessage.toString();
    }
    notifyListeners();
  }

  Future<DeviceStatusResponse?> _callingDeviceStatusApi() {
    var completer = Completer<DeviceStatusResponse?>();
    service.getDeviceStatus(deviceBarcode).listen((event) {
      completer.complete(event);
    }, onError: (error) {
      completer.completeError(error);
    });
    return completer.future;
  }

  @override
  void dispose() {
    CalculatorDataHolderModel().resetAllData();
    super.dispose();
  }

  void getManualQuestions() {
    iDeviceQuote?.showLoading(true);
    service.getManualQuestions(deviceBarcode).listen((event) {
      iDeviceQuote?.showLoading(false);
      if (!Validator.isListNullOrEmpty(event?.questionList)) {
        iDeviceQuote?.onManualQuestionFetchedSuccess(event!.questionList!);
      } else {
        getDeviceColors();
      }
    }, onError: (error) {
      // var errorMessage = ApiErrorHelper.getErrorMessage(error);
      getDeviceColors();
    }, onDone: () {
      notifyListeners();
    });
  }

  void onManualQuestionAnswered(List<ManualQuestionListData> questionList) {
    questionList.retainWhere((element) => element.value == 1);
    AnalyticsController.logEvent(
        AdditionalQuestionsSelectedEvent(deviceBarcode, questionList.map((e) => e.question).toList()));
    _questionList = questionList;
    getDeviceColors();
  }

  _submitManualQuestions() {
    if (Validator.isListNullOrEmpty(_questionList)) {
      return;
    }
    service.submitManualQuestions(deviceBarcode, _questionList?.map((e) => e.question).toList()).listen((event) {},
        onError: (error) {
      Logger.debug('mydebug-----SubmitDeviceQuoteProvider._submitManualQuestions error', [error]);
    });
  }

  void submitTrcRemarks(String testingRemarks) {
    _submitCalculatorRequest(testingRemarks: testingRemarks);
  }

  void resetQcImageCaptureFlag() {
    isCaptureQcImages = false;
    notifyListeners();
  }
}
