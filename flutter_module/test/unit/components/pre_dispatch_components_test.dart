import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/pre_dispatch/components/pre_dispatch_component.dart';
import 'package:flutter_trc/qc/modules/pre_dispatch/components/pre_dispatch_lots_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('PreDispatchComponent', () {
    test('has correct COMP_KEY', () {
      expect(PreDispatchComponent.COMP_KEY, 'QC_qc_pre_dispatch_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = PreDispatchComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = PreDispatchComponent({});
      expect(component, isNotNull);
    });
  });

  group('PreDispatchLotsComponent', () {
    test('has correct COMP_KEY', () {
      expect(PreDispatchLotsComponent.COMP_KEY, 'QC_qc_pre_dispatch_lots_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = PreDispatchLotsComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = PreDispatchLotsComponent({});
      expect(component, isNotNull);
    });
  });
}
