final class AnalyticEventKeys {
  static final manualTesting = _ManualTesting();
}

class _ManualTesting with _CommonKeys {
  _ManualTesting._private();

  static final _ManualTesting _instance = _ManualTesting._private();

  factory _ManualTesting() => _instance;

  final String subOrdinateKey = "dmt_manual_testing";

  final String startManualTesting = "dmt_start_manual_testing";

  final String scanManualTestBarcode = "dmt_scan_manual_test_barcode";

  final String deviceVerifyPopup = "dmt_device_verify_pop_up";

  final String updateDeviceCategory = "dmt_update_device_category";

  final String manualSearchButtonClicked = "dmt_manual_search_button_clicked";

  final String autoSearchButtonClicked = "dmt_auto_search_button_clicked";

  final String productSearchClicked = "dmt_product_search_clicked";

  final String endTestingSession = "dmt_end_testing_session";

  final String colorSelected = "dmt_color_selected";

  final String colorView = "dmt_color_view";

  final String additionalQuestionView = "dmt_additional_question_view";

  final String additionalQuestionSelected = "dmt_additional_question";

  final String calWithPageNo = "dmt_cal_p";

  final String calFinished = "dmt_calc_finished";

  final String reCalculate = "dmt_calc_re_calculate";

  final String calculatorSummaryView = "dmt_calc_summary";

  final String moveToPreviousScreen = "dmt_calc_move_to_previous_screen";

}

mixin _CommonKeys {
  final String login = "login";
}
