import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dead_repair/components/device_dead_accept_reject_component.dart';
import 'package:flutter_trc/qc/modules/dead_repair/components/device_dead_component.dart';
import 'package:flutter_trc/qc/modules/dead_repair/components/reason_selection_component.dart';
import 'package:flutter_trc/qc/modules/dead_repair/widgets/index.dart';
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

    test('can be instantiated with non-empty config', () {
      const component = DeviceDeadComponent({'key': 'value'});
      expect(component, isNotNull);
    });

    test('COMP_KEY follows naming convention', () {
      expect(DeviceDeadComponent.COMP_KEY, startsWith('QC_'));
      expect(DeviceDeadComponent.COMP_KEY, contains('device_dead'));
      expect(DeviceDeadComponent.COMP_KEY, endsWith('_component'));
    });

    testWidgets('buildView returns DeadDeviceWidget', (tester) async {
      const component = DeviceDeadComponent({});
      Widget? builtWidget;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          builtWidget = component.buildView(context, NoneConfigModel());
          return const SizedBox();
        }),
      ));
      await tester.pump();
      expect(builtWidget, isA<DeadDeviceWidget>());
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

    test('can be instantiated with non-empty config', () {
      const component = DeviceDeadAcceptRejectComponent({'key': 'value'});
      expect(component, isNotNull);
    });

    test('COMP_KEY follows naming convention', () {
      expect(DeviceDeadAcceptRejectComponent.COMP_KEY, startsWith('QC_'));
      expect(DeviceDeadAcceptRejectComponent.COMP_KEY, contains('device_dead'));
      expect(DeviceDeadAcceptRejectComponent.COMP_KEY, contains('accept_reject'));
      expect(DeviceDeadAcceptRejectComponent.COMP_KEY, endsWith('_component'));
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

    test('can be instantiated with non-empty config', () {
      const component = ReasonSelectionComponent({'key': 'value'});
      expect(component, isNotNull);
    });

    test('COMP_KEY follows naming convention', () {
      expect(ReasonSelectionComponent.COMP_KEY, startsWith('QC_'));
      expect(ReasonSelectionComponent.COMP_KEY, contains('reason_selection'));
      expect(ReasonSelectionComponent.COMP_KEY, endsWith('_component'));
    });
  });

  group('Dead Repair Components - Cross-Component Tests', () {
    test('all dead repair components have unique COMP_KEYs', () {
      final compKeys = [
        DeviceDeadComponent.COMP_KEY,
        DeviceDeadAcceptRejectComponent.COMP_KEY,
        ReasonSelectionComponent.COMP_KEY,
      ];

      expect(compKeys.toSet().length, compKeys.length,
          reason: 'All COMP_KEYs should be unique');
    });

    test('all dead repair components follow QC prefix convention', () {
      expect(DeviceDeadComponent.COMP_KEY, startsWith('QC_'));
      expect(DeviceDeadAcceptRejectComponent.COMP_KEY, startsWith('QC_'));
      expect(ReasonSelectionComponent.COMP_KEY, startsWith('QC_'));
    });

    test('all dead repair components use NoneConfigModel', () {
      const deviceDead = DeviceDeadComponent({});
      const acceptReject = DeviceDeadAcceptRejectComponent({});
      const reasonSelection = ReasonSelectionComponent({});

      expect(deviceDead.fromConfig(), NoneConfigModel.fromConfig);
      expect(acceptReject.fromConfig(), NoneConfigModel.fromConfig);
      expect(reasonSelection.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('COMP_KEYs contain qc prefix for module identification', () {
      // All dead repair components have 'qc_qc' pattern for module identification
      expect(DeviceDeadComponent.COMP_KEY, contains('qc_'));
      expect(DeviceDeadAcceptRejectComponent.COMP_KEY, contains('qc_'));
      expect(ReasonSelectionComponent.COMP_KEY, contains('qc_'));
    });
  });

  group('Dead Repair Components - COMP_KEY Structure Validation', () {
    test('DeviceDeadComponent COMP_KEY structure', () {
      const key = DeviceDeadComponent.COMP_KEY;
      final parts = key.split('_');

      // QC_qc_device_dead_component
      expect(parts.first, 'QC');
      expect(parts.last, 'component');
      expect(parts.length, greaterThanOrEqualTo(4));
    });

    test('DeviceDeadAcceptRejectComponent COMP_KEY structure', () {
      const key = DeviceDeadAcceptRejectComponent.COMP_KEY;
      final parts = key.split('_');

      // QC_qc_device_dead_accept_reject_component
      expect(parts.first, 'QC');
      expect(parts.last, 'component');
      expect(key, contains('accept'));
      expect(key, contains('reject'));
    });

    test('ReasonSelectionComponent COMP_KEY structure', () {
      const key = ReasonSelectionComponent.COMP_KEY;
      final parts = key.split('_');

      // QC_qc_reason_selection_component
      expect(parts.first, 'QC');
      expect(parts.last, 'component');
      expect(key, contains('reason'));
      expect(key, contains('selection'));
    });
  });
}
