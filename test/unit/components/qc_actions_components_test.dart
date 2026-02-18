import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_actions/component/qc_action_component.dart';
import 'package:flutter_trc/qc/modules/qc_actions/models/qc_action_comp_config.dart';

void main() {
  group('QcActionComponent', () {
    test('has correct COMP_KEY', () {
      expect(QcActionComponent.COMP_KEY, 'QC_qc_action_component');
    });

    test('fromConfig returns QcActionConfig.fromConfig', () {
      const component = QcActionComponent({});
      expect(component.fromConfig(), QcActionConfig.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = QcActionComponent({});
      expect(component, isNotNull);
    });
  });
}
