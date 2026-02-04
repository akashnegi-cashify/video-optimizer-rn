import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/imei_validator/components/imei_validator_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('ImeiValidatorComponent', () {
    test('has correct COMP_KEY', () {
      expect(ImeiValidatorComponent.COMP_KEY, 'QC_imei_validator_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = ImeiValidatorComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = ImeiValidatorComponent({});
      expect(component, isNotNull);
    });
  });
}
