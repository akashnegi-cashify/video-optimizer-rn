import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_out/components/store_out_component.dart';
import 'package:flutter_trc/qc/modules/store_out/components/lot_items_scan_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

void main() {
  group('StoreOutComponent', () {
    test('has correct COMP_KEY', () {
      expect(StoreOutComponent.COMP_KEY, 'QC_qc_store_out_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = StoreOutComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = StoreOutComponent({});
      expect(component, isNotNull);
    });

    test('can be instantiated with non-empty config', () {
      const component = StoreOutComponent({'key': 'value'});
      expect(component, isNotNull);
    });

    test('buildView method exists and is callable', () {
      const component = StoreOutComponent({});
      expect(component.buildView, isNotNull);
    });

    test('COMP_KEY follows naming convention', () {
      expect(StoreOutComponent.COMP_KEY, startsWith('QC_'));
      expect(StoreOutComponent.COMP_KEY, contains('store_out'));
    });

    test('component is const constructible', () {
      const component1 = StoreOutComponent({});
      const component2 = StoreOutComponent({});
      expect(component1, isNotNull);
      expect(component2, isNotNull);
    });

    testWidgets('buildView returns ChangeNotifierProvider', (tester) async {
      const component = StoreOutComponent({});
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
      const component = StoreOutComponent({});
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

  group('LotItemsScanComponent', () {
    test('has correct COMP_KEY', () {
      expect(LotItemsScanComponent.COMP_KEY, 'QC_qc_lot_items_scan_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = LotItemsScanComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = LotItemsScanComponent({});
      expect(component, isNotNull);
    });

    test('can be instantiated with non-empty config', () {
      const component = LotItemsScanComponent({'key': 'value'});
      expect(component, isNotNull);
    });

    test('buildView method exists and is callable', () {
      const component = LotItemsScanComponent({});
      expect(component.buildView, isNotNull);
    });

    test('COMP_KEY follows naming convention', () {
      expect(LotItemsScanComponent.COMP_KEY, startsWith('QC_'));
      expect(LotItemsScanComponent.COMP_KEY, contains('lot_items_scan'));
    });

    test('component is const constructible', () {
      const component1 = LotItemsScanComponent({});
      const component2 = LotItemsScanComponent({});
      expect(component1, isNotNull);
      expect(component2, isNotNull);
    });

    testWidgets('buildView does not throw with valid context', (tester) async {
      const component = LotItemsScanComponent({});
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

  group('Store Out Components Integration', () {
    test('all components have unique COMP_KEYs', () {
      final keys = [
        StoreOutComponent.COMP_KEY,
        LotItemsScanComponent.COMP_KEY,
      ];
      expect(keys.toSet().length, equals(keys.length));
    });

    test('all components use NoneConfigModel', () {
      const storeOut = StoreOutComponent({});
      const lotItemsScan = LotItemsScanComponent({});

      expect(storeOut.fromConfig(), NoneConfigModel.fromConfig);
      expect(lotItemsScan.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('all COMP_KEYs follow QC naming convention', () {
      expect(StoreOutComponent.COMP_KEY, startsWith('QC_qc_'));
      expect(LotItemsScanComponent.COMP_KEY, startsWith('QC_qc_'));
    });
  });
}
