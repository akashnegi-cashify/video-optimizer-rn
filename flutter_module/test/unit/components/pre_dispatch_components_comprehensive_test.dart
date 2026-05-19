import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/pre_dispatch/components/pre_dispatch_component.dart';
import 'package:flutter_trc/qc/modules/pre_dispatch/components/pre_dispatch_lots_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

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

    test('can be instantiated with non-empty config', () {
      const component = PreDispatchComponent({'key': 'value'});
      expect(component, isNotNull);
    });

    test('buildView method exists and is callable', () {
      const component = PreDispatchComponent({});
      expect(component.buildView, isNotNull);
    });

    test('COMP_KEY follows naming convention', () {
      expect(PreDispatchComponent.COMP_KEY, startsWith('QC_'));
      expect(PreDispatchComponent.COMP_KEY, contains('pre_dispatch'));
    });

    test('component is const constructible', () {
      const component1 = PreDispatchComponent({});
      const component2 = PreDispatchComponent({});
      expect(component1, isNotNull);
      expect(component2, isNotNull);
    });

    testWidgets('buildView does not throw with valid context', (tester) async {
      const component = PreDispatchComponent({});
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

    testWidgets('buildView returns a Widget', (tester) async {
      const component = PreDispatchComponent({});
      Widget? builtWidget;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          builtWidget = component.buildView(context, NoneConfigModel());
          return const SizedBox();
        }),
      ));
      await tester.pump();
      // PreDispatchComponent uses paramBuilder which returns a Widget
      expect(builtWidget, isA<Widget>());
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

    test('can be instantiated with non-empty config', () {
      const component = PreDispatchLotsComponent({'key': 'value'});
      expect(component, isNotNull);
    });

    test('buildView method exists and is callable', () {
      const component = PreDispatchLotsComponent({});
      expect(component.buildView, isNotNull);
    });

    test('COMP_KEY follows naming convention', () {
      expect(PreDispatchLotsComponent.COMP_KEY, startsWith('QC_'));
      expect(PreDispatchLotsComponent.COMP_KEY, contains('pre_dispatch'));
      expect(PreDispatchLotsComponent.COMP_KEY, contains('lots'));
    });

    test('component is const constructible', () {
      const component1 = PreDispatchLotsComponent({});
      const component2 = PreDispatchLotsComponent({});
      expect(component1, isNotNull);
      expect(component2, isNotNull);
    });

    testWidgets('buildView returns ChangeNotifierProvider', (tester) async {
      const component = PreDispatchLotsComponent({});
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
      const component = PreDispatchLotsComponent({});
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

  group('Pre Dispatch Components Integration', () {
    test('all components have unique COMP_KEYs', () {
      final keys = [
        PreDispatchComponent.COMP_KEY,
        PreDispatchLotsComponent.COMP_KEY,
      ];
      expect(keys.toSet().length, equals(keys.length));
    });

    test('all components use NoneConfigModel', () {
      const preDispatch = PreDispatchComponent({});
      const preDispatchLots = PreDispatchLotsComponent({});

      expect(preDispatch.fromConfig(), NoneConfigModel.fromConfig);
      expect(preDispatchLots.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('all COMP_KEYs follow QC naming convention', () {
      expect(PreDispatchComponent.COMP_KEY, startsWith('QC_qc_'));
      expect(PreDispatchLotsComponent.COMP_KEY, startsWith('QC_qc_'));
    });

    test('COMP_KEYs are descriptive of component purpose', () {
      expect(PreDispatchComponent.COMP_KEY, contains('pre_dispatch'));
      expect(PreDispatchLotsComponent.COMP_KEY, contains('pre_dispatch'));
      expect(PreDispatchLotsComponent.COMP_KEY, contains('lots'));
    });

    test('component COMP_KEYs differentiate between single and list views', () {
      // PreDispatchComponent is for single item view
      expect(PreDispatchComponent.COMP_KEY, isNot(contains('lots')));
      // PreDispatchLotsComponent is for list view
      expect(PreDispatchLotsComponent.COMP_KEY, contains('lots'));
    });
  });
}
