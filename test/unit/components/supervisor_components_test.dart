import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/supervisor/components/supervisor_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('SupervisorComponent', () {
    test('has correct COMP_KEY', () {
      expect(SupervisorComponent.COMP_KEY, 'QC_supervisor_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = SupervisorComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = SupervisorComponent({});
      expect(component, isNotNull);
    });
  });
}
