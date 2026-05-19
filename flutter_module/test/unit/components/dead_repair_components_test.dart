import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dead_repair/components/device_dead_component.dart';
import 'package:flutter_trc/qc/modules/dead_repair/components/device_dead_accept_reject_component.dart';
import 'package:flutter_trc/qc/modules/dead_repair/components/reason_selection_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('DeviceDeadComponent', () {
    test('has correct COMP_KEY', () {
      expect(DeviceDeadComponent.COMP_KEY, 'QC_qc_device_dead_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = DeviceDeadComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = DeviceDeadComponent({});
      expect(component, isNotNull);
    });
  });

  group('DeviceDeadAcceptRejectComponent', () {
    test('has correct COMP_KEY', () {
      expect(DeviceDeadAcceptRejectComponent.COMP_KEY, 'QC_qc_device_dead_accept_reject_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = DeviceDeadAcceptRejectComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = DeviceDeadAcceptRejectComponent({});
      expect(component, isNotNull);
    });
  });

  group('ReasonSelectionComponent', () {
    test('has correct COMP_KEY', () {
      expect(ReasonSelectionComponent.COMP_KEY, 'QC_qc_reason_selection_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = ReasonSelectionComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = ReasonSelectionComponent({});
      expect(component, isNotNull);
    });
  });
}
