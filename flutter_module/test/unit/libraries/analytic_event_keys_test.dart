import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';

void main() {
  group('AnalyticEventKeys', () {
    group('manualTesting', () {
      test('should have correct parentEventKey', () {
        expect(AnalyticEventKeys.manualTesting.parentEventKey, equals('dmt_manual_testing'));
      });

      test('should have correct startManualTesting key', () {
        expect(AnalyticEventKeys.manualTesting.startManualTesting, equals('dmt_start_manual_testing'));
      });

      test('should have correct scanManualTestBarcode key', () {
        expect(AnalyticEventKeys.manualTesting.scanManualTestBarcode, equals('dmt_scan_manual_test_barcode'));
      });

      test('should have correct deviceVerifyPopup key', () {
        expect(AnalyticEventKeys.manualTesting.deviceVerifyPopup, equals('dmt_device_verify_pop_up'));
      });

      test('should have correct updateDeviceCategory key', () {
        expect(AnalyticEventKeys.manualTesting.updateDeviceCategory, equals('dmt_update_device_category'));
      });

      test('should have correct selectBrand key', () {
        expect(AnalyticEventKeys.manualTesting.selectBrand, equals('dmt_select_brand'));
      });

      test('should have correct manualSearchButtonClicked key', () {
        expect(AnalyticEventKeys.manualTesting.manualSearchButtonClicked, equals('dmt_manual_search_button_clicked'));
      });

      test('should have correct autoSearchButtonClicked key', () {
        expect(AnalyticEventKeys.manualTesting.autoSearchButtonClicked, equals('dmt_auto_search_button_clicked'));
      });

      test('should have correct productSearchClicked key', () {
        expect(AnalyticEventKeys.manualTesting.productSearchClicked, equals('dmt_product_search_clicked'));
      });

      test('should have correct variantSearchClicked key', () {
        expect(AnalyticEventKeys.manualTesting.variantSearchClicked, equals('dmt_variant_search_clicked'));
      });

      test('should have correct endTestingSession key', () {
        expect(AnalyticEventKeys.manualTesting.endTestingSession, equals('dmt_end_testing_session'));
      });

      test('should have correct colorSelected key', () {
        expect(AnalyticEventKeys.manualTesting.colorSelected, equals('dmt_color_selected'));
      });

      test('should have correct colorView key', () {
        expect(AnalyticEventKeys.manualTesting.colorView, equals('dmt_color_view'));
      });

      test('should have correct additionalQuestionView key', () {
        expect(AnalyticEventKeys.manualTesting.additionalQuestionView, equals('dmt_additional_question_view'));
      });

      test('should have correct additionalQuestionSelected key', () {
        expect(AnalyticEventKeys.manualTesting.additionalQuestionSelected, equals('dmt_additional_question'));
      });

      test('should have correct calWithPageNo key', () {
        expect(AnalyticEventKeys.manualTesting.calWithPageNo, equals('dmt_cal_p'));
      });

      test('should have correct calFinished key', () {
        expect(AnalyticEventKeys.manualTesting.calFinished, equals('dmt_calc_finished'));
      });

      test('should have correct reCalculate key', () {
        expect(AnalyticEventKeys.manualTesting.reCalculate, equals('dmt_calc_re_calculate'));
      });

      test('should have correct calculatorSummaryView key', () {
        expect(AnalyticEventKeys.manualTesting.calculatorSummaryView, equals('dmt_calc_summary'));
      });

      test('should have correct moveToPreviousScreen key', () {
        expect(AnalyticEventKeys.manualTesting.moveToPreviousScreen, equals('dmt_calc_move_to_previous_screen'));
      });
    });

    group('common', () {
      test('should have correct qcLogin key', () {
        expect(AnalyticEventKeys.common.qcLogin, equals('qc_login'));
      });

      test('should have correct login key', () {
        expect(AnalyticEventKeys.common.login, equals('login'));
      });
    });

    group('inheritance', () {
      test('manualTesting should inherit common keys', () {
        // manualTesting extends _CommonKeys, so it should have access to common keys
        expect(AnalyticEventKeys.manualTesting.qcLogin, equals('qc_login'));
        expect(AnalyticEventKeys.manualTesting.login, equals('login'));
      });
    });

    group('singleton pattern', () {
      test('manualTesting should return same instance', () {
        final instance1 = AnalyticEventKeys.manualTesting;
        final instance2 = AnalyticEventKeys.manualTesting;
        expect(identical(instance1, instance2), isTrue);
      });
    });

    group('key format', () {
      test('all manual testing keys should start with dmt_', () {
        final keys = [
          AnalyticEventKeys.manualTesting.parentEventKey,
          AnalyticEventKeys.manualTesting.startManualTesting,
          AnalyticEventKeys.manualTesting.scanManualTestBarcode,
          AnalyticEventKeys.manualTesting.deviceVerifyPopup,
          AnalyticEventKeys.manualTesting.updateDeviceCategory,
          AnalyticEventKeys.manualTesting.selectBrand,
          AnalyticEventKeys.manualTesting.manualSearchButtonClicked,
          AnalyticEventKeys.manualTesting.autoSearchButtonClicked,
          AnalyticEventKeys.manualTesting.productSearchClicked,
          AnalyticEventKeys.manualTesting.variantSearchClicked,
          AnalyticEventKeys.manualTesting.endTestingSession,
          AnalyticEventKeys.manualTesting.colorSelected,
          AnalyticEventKeys.manualTesting.colorView,
          AnalyticEventKeys.manualTesting.additionalQuestionView,
          AnalyticEventKeys.manualTesting.additionalQuestionSelected,
          AnalyticEventKeys.manualTesting.calWithPageNo,
          AnalyticEventKeys.manualTesting.calFinished,
          AnalyticEventKeys.manualTesting.reCalculate,
          AnalyticEventKeys.manualTesting.calculatorSummaryView,
          AnalyticEventKeys.manualTesting.moveToPreviousScreen,
        ];

        for (final key in keys) {
          expect(key.startsWith('dmt_'), isTrue, reason: 'Key "$key" should start with "dmt_"');
        }
      });

      test('all keys should be non-empty', () {
        final keys = [
          AnalyticEventKeys.manualTesting.parentEventKey,
          AnalyticEventKeys.manualTesting.startManualTesting,
          AnalyticEventKeys.common.qcLogin,
          AnalyticEventKeys.common.login,
        ];

        for (final key in keys) {
          expect(key.isNotEmpty, isTrue);
        }
      });

      test('all keys should not contain spaces', () {
        final keys = [
          AnalyticEventKeys.manualTesting.parentEventKey,
          AnalyticEventKeys.manualTesting.startManualTesting,
          AnalyticEventKeys.common.qcLogin,
          AnalyticEventKeys.common.login,
        ];

        for (final key in keys) {
          expect(key.contains(' '), isFalse, reason: 'Key "$key" should not contain spaces');
        }
      });
    });
  });
}
