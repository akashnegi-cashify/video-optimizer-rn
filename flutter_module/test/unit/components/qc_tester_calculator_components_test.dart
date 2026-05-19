import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/component/calculator_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/component/calculator_scanner_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/component/disputed_question_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/component/submit_device_quote_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('CalculatorComponent', () {
    test('has correct COMP_KEY', () {
      expect(CalculatorComponent.COMP_KEY, 'calculator_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = CalculatorComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = CalculatorComponent({});
      expect(component, isNotNull);
    });
  });

  group('CalculatorScannerComponent', () {
    test('has correct COMP_KEY', () {
      expect(CalculatorScannerComponent.COMP_KEY, 'QC_calculator_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = CalculatorScannerComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = CalculatorScannerComponent({});
      expect(component, isNotNull);
    });
  });

  group('DisputedQuestionsComponent', () {
    test('has correct COMP_KEY', () {
      expect(DisputedQuestionsComponent.COMP_KEY, 'disputed_questions');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = DisputedQuestionsComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = DisputedQuestionsComponent({});
      expect(component, isNotNull);
    });
  });

  group('SubmitDeviceQuoteComponent', () {
    test('has correct COMP_KEY', () {
      expect(SubmitDeviceQuoteComponent.COMP_KEY, 'QC_submit_device_quote_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = SubmitDeviceQuoteComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = SubmitDeviceQuoteComponent({});
      expect(component, isNotNull);
    });
  });
}
