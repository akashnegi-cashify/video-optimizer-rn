import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/media_submit_request.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_quote_request_data.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
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
  String? _selectedColor;

  MyCalculatorResponse? _calculatorResponse;
  List<MediaSubmitRequest>? _mediaList;
  int? _selectedCategoryId;
  VariantListData? _variantData;

  VariantListData? get variantData => _variantData;

  int? get selectedCategoryId => _selectedCategoryId;

  DeviceType _deviceType = DeviceType.mobile_device;

  List<MediaSubmitRequest>? get mediaList => _mediaList;

  void startCalculatorJourney(MyCalculatorResponse? calculatorResponse, String? deviceBarcode,
      {DeviceType deviceType = DeviceType.mobile_device, int? selectedCategoryId, VariantListData? variantData}) {
    resetAllData();

    // add Experiment for server side rule executor or not
    if (RemoteConfigHelper().getBoolean(AppRemoteConfig.KEY_IS_ENABLE_RULE_EXE_TEST_MODE)) {
      if (RemoteConfigHelper().getBoolean(AppRemoteConfig.KEY_IS_FORCE_SERVER_RULE_EXECUTOR)) {
        calculatorResponse?.ruleExecutionMode = 1;
      } else {
        calculatorResponse?.ruleExecutionMode = 0;
      }
    }

    calculatorResponse?.productName = calculatorResponse.deviceName?.trim();

    _calculatorResponse = calculatorResponse;
    _selectedCategoryId = selectedCategoryId;
    _deviceBarcode = deviceBarcode;
    _deviceType = deviceType;
    _variantData = variantData;
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
    _quoteRequestData?.selectedColor = _selectedColor;
    if (_selectedCategoryId != null) {
      _quoteRequestData?.categoryId = _selectedCategoryId;
    }
  }

  setSelectedColor(String color) {
    _selectedColor = color;
  }

  resetAllData() {
    _deviceBarcode = null;
    _quoteRequestData = null;
    _calculatorResponse = null;
    _mediaList = null;
    _selectedCategoryId = null;
    _deviceType = DeviceType.mobile_device;
    _variantData = null;
    _selectedColor = null;
  }

  factory CalculatorDataHolderModel() {
    return _instance;
  }
}
