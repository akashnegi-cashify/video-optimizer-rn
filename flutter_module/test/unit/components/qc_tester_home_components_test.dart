import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/home/component/qc_tester_home_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('QcTesterHomeComponent', () {
    test('has correct COMP_KEY', () {
      expect(QcTesterHomeComponent.COMP_KEY, 'QC_qc_tester_home');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = QcTesterHomeComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = QcTesterHomeComponent({});
      expect(component, isNotNull);
    });
  });
}
