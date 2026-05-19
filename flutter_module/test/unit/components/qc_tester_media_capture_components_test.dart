import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator_media_capture/components/calculator_media_capture_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('CalculatorMediaCaptureComponent', () {
    test('has correct COMP_KEY', () {
      expect(CalculatorMediaCaptureComponent.COMP_KEY, 'calculator_media_capture');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = CalculatorMediaCaptureComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = CalculatorMediaCaptureComponent({});
      expect(component, isNotNull);
    });
  });
}
