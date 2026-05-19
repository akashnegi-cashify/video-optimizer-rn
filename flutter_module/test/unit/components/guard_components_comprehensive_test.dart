import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/gaurd/components/guard_device_counting_list_component.dart';
import 'package:flutter_trc/qc/modules/gaurd/components/guard_upload_invoice_component.dart';
import 'package:flutter_trc/qc/modules/gaurd/components/qc_guard_add_agent_component.dart';
import 'package:flutter_trc/qc/modules/gaurd/components/qc_guard_home_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

void main() {
  group('GuardUploadInvoiceComponent', () {
    test('has correct COMP_KEY', () {
      expect(GuardUploadInvoiceComponent.COMP_KEY, 'QC_guard_upload_invoice_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = GuardUploadInvoiceComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = GuardUploadInvoiceComponent({});
      expect(component, isNotNull);
    });

    test('can be instantiated with non-empty config', () {
      const component = GuardUploadInvoiceComponent({'key': 'value'});
      expect(component, isNotNull);
    });

    test('COMP_KEY follows naming convention', () {
      expect(GuardUploadInvoiceComponent.COMP_KEY, startsWith('QC_'));
      expect(GuardUploadInvoiceComponent.COMP_KEY, contains('guard'));
      expect(GuardUploadInvoiceComponent.COMP_KEY, endsWith('_component'));
    });
  });

  group('QcGuardHomeComponent', () {
    test('has correct COMP_KEY', () {
      expect(QcGuardHomeComponent.COMP_KEY, 'QC_guard_home_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = QcGuardHomeComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = QcGuardHomeComponent({});
      expect(component, isNotNull);
    });

    test('can be instantiated with non-empty config', () {
      const component = QcGuardHomeComponent({'key': 'value'});
      expect(component, isNotNull);
    });

    test('COMP_KEY follows naming convention', () {
      expect(QcGuardHomeComponent.COMP_KEY, startsWith('QC_'));
      expect(QcGuardHomeComponent.COMP_KEY, contains('guard'));
      expect(QcGuardHomeComponent.COMP_KEY, endsWith('_component'));
    });

    testWidgets('buildView returns ChangeNotifierProvider', (tester) async {
      const component = QcGuardHomeComponent({});
      Widget? builtWidget;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          builtWidget = component.buildView(context, NoneConfigModel());
          return const SizedBox();
        }),
      ));
      await tester.pump();
      expect(builtWidget, isA<ChangeNotifierProvider>());
    });
  });

  group('QcGuardAddAgentComponent', () {
    test('has correct COMP_KEY', () {
      expect(QcGuardAddAgentComponent.COMP_KEY, 'QC_guard_add_agent_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = QcGuardAddAgentComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = QcGuardAddAgentComponent({});
      expect(component, isNotNull);
    });

    test('can be instantiated with non-empty config', () {
      const component = QcGuardAddAgentComponent({'key': 'value'});
      expect(component, isNotNull);
    });

    test('COMP_KEY follows naming convention', () {
      expect(QcGuardAddAgentComponent.COMP_KEY, startsWith('QC_'));
      expect(QcGuardAddAgentComponent.COMP_KEY, contains('guard'));
      expect(QcGuardAddAgentComponent.COMP_KEY, endsWith('_component'));
    });
  });

  group('GuardDeviceCountingListComponent', () {
    test('has correct COMP_KEY', () {
      expect(GuardDeviceCountingListComponent.COMP_KEY, 'QC_guard_device_counting_list_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = GuardDeviceCountingListComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = GuardDeviceCountingListComponent({});
      expect(component, isNotNull);
    });

    test('can be instantiated with non-empty config', () {
      const component = GuardDeviceCountingListComponent({'key': 'value'});
      expect(component, isNotNull);
    });

    test('COMP_KEY follows naming convention', () {
      expect(GuardDeviceCountingListComponent.COMP_KEY, startsWith('QC_'));
      expect(GuardDeviceCountingListComponent.COMP_KEY, contains('guard'));
      expect(GuardDeviceCountingListComponent.COMP_KEY, endsWith('_component'));
    });

    testWidgets('buildView returns ChangeNotifierProvider', (tester) async {
      const component = GuardDeviceCountingListComponent({});
      Widget? builtWidget;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          builtWidget = component.buildView(context, NoneConfigModel());
          return const SizedBox();
        }),
      ));
      await tester.pump();
      expect(builtWidget, isA<ChangeNotifierProvider>());
    });
  });

  group('Guard Components - Cross-Component Tests', () {
    test('all guard components have unique COMP_KEYs', () {
      final compKeys = [
        GuardUploadInvoiceComponent.COMP_KEY,
        QcGuardHomeComponent.COMP_KEY,
        QcGuardAddAgentComponent.COMP_KEY,
        GuardDeviceCountingListComponent.COMP_KEY,
      ];

      expect(compKeys.toSet().length, compKeys.length,
          reason: 'All COMP_KEYs should be unique');
    });

    test('all guard components follow QC prefix convention', () {
      expect(GuardUploadInvoiceComponent.COMP_KEY, startsWith('QC_'));
      expect(QcGuardHomeComponent.COMP_KEY, startsWith('QC_'));
      expect(QcGuardAddAgentComponent.COMP_KEY, startsWith('QC_'));
      expect(GuardDeviceCountingListComponent.COMP_KEY, startsWith('QC_'));
    });

    test('all guard components use NoneConfigModel', () {
      const uploadInvoice = GuardUploadInvoiceComponent({});
      const guardHome = QcGuardHomeComponent({});
      const addAgent = QcGuardAddAgentComponent({});
      const deviceCounting = GuardDeviceCountingListComponent({});

      expect(uploadInvoice.fromConfig(), NoneConfigModel.fromConfig);
      expect(guardHome.fromConfig(), NoneConfigModel.fromConfig);
      expect(addAgent.fromConfig(), NoneConfigModel.fromConfig);
      expect(deviceCounting.fromConfig(), NoneConfigModel.fromConfig);
    });
  });
}
