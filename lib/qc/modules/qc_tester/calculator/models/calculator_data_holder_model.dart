import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/media_submit_request.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_quote_request_data.dart';
import 'package:flutter_trc/src/libraries/firebase/remote_config_helper.dart';

enum DeviceType {
  lob_device,
  mobile_device;
}

class CalculatorDataHolderModel {
  CalculatorDataHolderModel._privateConstructor();

  static final CalculatorDataHolderModel _instance = CalculatorDataHolderModel._privateConstructor();

  MyQuoteRequestData? _quoteRequestData;
  String? _deviceBarcode;

  MyCalculatorResponse? _calculatorResponse;
  List<MediaSubmitRequest>? _mediaList;

  DeviceType _deviceType = DeviceType.mobile_device;

  List<MediaSubmitRequest>? get mediaList => _mediaList;

  void startCalculatorJourney(MyCalculatorResponse? calculatorResponse, String? deviceBarcode,
      {DeviceType deviceType = DeviceType.mobile_device}) {
    resetAllData();
    _calculatorResponse = calculatorResponse;
    _deviceBarcode = deviceBarcode;
    _deviceType = deviceType;
  }

  set mediaList(List<MediaSubmitRequest>? value) {
    _mediaList = value;
  }

  bool isDeviceTypeLob() {
    return _deviceType == DeviceType.lob_device;
  }

  MyCalculatorResponse? get calculatorResponse => _calculatorResponse;

  String? get deviceBarcode => _deviceBarcode;

  MyQuoteRequestData? get quoteRequestData => _quoteRequestData;

  set quoteRequestData(MyQuoteRequestData? value) {
    _quoteRequestData = value;
  }

  setSelectedColor(String color) {
    _quoteRequestData?.selectedColor = color;
  }

  resetAllData() {
    _deviceBarcode = null;
    _quoteRequestData = null;
    _calculatorResponse = null;
    _mediaList = null;
    _deviceType = DeviceType.mobile_device;
  }

  bool get isCaptureMediaMandatory =>
      RemoteConfigHelper().getBoolean(AppRemoteConfig.KEY_IS_CAPTURE_MEDIA_MANDATORY_IN_QC);

  factory CalculatorDataHolderModel() {
    return _instance;
  }
}
