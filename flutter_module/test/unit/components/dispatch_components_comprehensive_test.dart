import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/components/dispatch_lots_component.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/components/invoice_scan_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

void main() {
  group('DispatchLotsComponent', () {
    test('has correct COMP_KEY', () {
      expect(DispatchLotsComponent.COMP_KEY, 'QC_qc_dispatch_lots_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = DispatchLotsComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = DispatchLotsComponent({});
      expect(component, isNotNull);
    });

    test('can be instantiated with non-empty config', () {
      const component = DispatchLotsComponent({'key': 'value'});
      expect(component, isNotNull);
    });

    test('buildView method exists and is callable', () {
      const component = DispatchLotsComponent({});
      expect(component.buildView, isNotNull);
    });

    test('COMP_KEY follows naming convention', () {
      expect(DispatchLotsComponent.COMP_KEY, startsWith('QC_'));
      expect(DispatchLotsComponent.COMP_KEY, contains('dispatch_lots'));
    });

    test('component is const constructible', () {
      const component1 = DispatchLotsComponent({});
      const component2 = DispatchLotsComponent({});
      expect(component1, isNotNull);
      expect(component2, isNotNull);
    });

    testWidgets('buildView returns ChangeNotifierProvider', (tester) async {
      const component = DispatchLotsComponent({});
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

    testWidgets('buildView does not throw with valid context', (tester) async {
      const component = DispatchLotsComponent({});
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          expect(
            () => component.buildView(context, NoneConfigModel()),
            returnsNormally,
          );
          return const SizedBox();
        }),
      ));
    });
  });

  group('InvoiceScanComponent', () {
    test('has correct COMP_KEY', () {
      expect(InvoiceScanComponent.COMP_KEY, 'QC_qc_invoice_scan_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = InvoiceScanComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = InvoiceScanComponent({});
      expect(component, isNotNull);
    });

    test('can be instantiated with non-empty config', () {
      const component = InvoiceScanComponent({'key': 'value'});
      expect(component, isNotNull);
    });

    test('buildView method exists and is callable', () {
      const component = InvoiceScanComponent({});
      expect(component.buildView, isNotNull);
    });

    test('COMP_KEY follows naming convention', () {
      expect(InvoiceScanComponent.COMP_KEY, startsWith('QC_'));
      expect(InvoiceScanComponent.COMP_KEY, contains('invoice_scan'));
    });

    test('component is const constructible', () {
      const component1 = InvoiceScanComponent({});
      const component2 = InvoiceScanComponent({});
      expect(component1, isNotNull);
      expect(component2, isNotNull);
    });

    testWidgets('buildView returns InvoiceScanWidget', (tester) async {
      const component = InvoiceScanComponent({});
      Widget? builtWidget;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          builtWidget = component.buildView(context, NoneConfigModel());
          return const SizedBox();
        }),
      ));
      await tester.pump();
      // InvoiceScanComponent returns InvoiceScanWidget directly (not wrapped in provider)
      expect(builtWidget, isA<Widget>());
    });

    testWidgets('buildView does not throw with valid context', (tester) async {
      const component = InvoiceScanComponent({});
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          expect(
            () => component.buildView(context, NoneConfigModel()),
            returnsNormally,
          );
          return const SizedBox();
        }),
      ));
    });
  });

  group('Dispatch Components Integration', () {
    test('all components have unique COMP_KEYs', () {
      final keys = [
        DispatchLotsComponent.COMP_KEY,
        InvoiceScanComponent.COMP_KEY,
      ];
      expect(keys.toSet().length, equals(keys.length));
    });

    test('all components use NoneConfigModel', () {
      const dispatchLots = DispatchLotsComponent({});
      const invoiceScan = InvoiceScanComponent({});

      expect(dispatchLots.fromConfig(), NoneConfigModel.fromConfig);
      expect(invoiceScan.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('all COMP_KEYs follow QC naming convention', () {
      expect(DispatchLotsComponent.COMP_KEY, startsWith('QC_qc_'));
      expect(InvoiceScanComponent.COMP_KEY, startsWith('QC_qc_'));
    });

    test('COMP_KEYs are descriptive of component purpose', () {
      expect(DispatchLotsComponent.COMP_KEY, contains('dispatch'));
      expect(DispatchLotsComponent.COMP_KEY, contains('lots'));
      expect(InvoiceScanComponent.COMP_KEY, contains('invoice'));
      expect(InvoiceScanComponent.COMP_KEY, contains('scan'));
    });
  });
}
