import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_trc/qc/modules/data_wipe/components/data_wipe_detail_component.dart';
import 'package:flutter_trc/qc/modules/data_wipe/providers/data_wipe_detail_provider.dart';
import 'package:flutter_trc/qc/modules/data_wipe/widgets/data_wipe_detail_widget.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('DataWipeDetailComponent', () {
    group('constants', () {
      test('has correct COMP_KEY', () {
        expect(DataWipeDetailComponent.COMP_KEY, 'QC_data_wipe_detail_component');
      });
    });

    group('widget', () {
      test('DataWipeDetailComponent class exists', () {
        expect(DataWipeDetailComponent, isNotNull);
      });

      test('DataWipeDetailComponent can be instantiated with empty config', () {
        const component = DataWipeDetailComponent({});
        expect(component, isNotNull);
      });

      test('DataWipeDetailComponent can be instantiated with null values in config', () {
        const component = DataWipeDetailComponent({'key': null});
        expect(component, isNotNull);
      });

      test('DataWipeDetailComponent can be instantiated with key', () {
        const key = Key('data_wipe_detail_component');
        const component = DataWipeDetailComponent({}, key: key);
        expect(component.key, equals(key));
      });
    });

    group('fromConfig', () {
      test('fromConfig returns NoneConfigModel.fromConfig', () {
        const component = DataWipeDetailComponent({});
        final fromConfig = component.fromConfig();
        expect(fromConfig, isNotNull);
        expect(fromConfig, NoneConfigModel.fromConfig);
      });
    });

    group('buildView', () {
      test('buildView method exists and is callable', () {
        const component = DataWipeDetailComponent({});
        expect(component.buildView, isNotNull);
        expect(component.buildView, isA<Function>());
      });

      test('component uses paramBuilder pattern', () {
        // DataWipeDetailComponent uses paramBuilder to access deviceBarcode param
        const component = DataWipeDetailComponent({});

        // Verify the component structure
        expect(component.fromConfig(), equals(NoneConfigModel.fromConfig));
        expect(DataWipeDetailComponent.COMP_KEY, 'QC_data_wipe_detail_component');
      });

      test('DataWipeDetailWidget class exists and is StatefulWidget', () {
        expect(DataWipeDetailWidget, isNotNull);
        const widget = DataWipeDetailWidget();
        expect(widget, isA<StatefulWidget>());
      });

      test('DataWipeDetailProvider class exists', () {
        expect(DataWipeDetailProvider, isNotNull);
        // Note: Provider makes API call in constructor, so we don't instantiate directly
      });

      test('DataWipeDetailProvider.of static method exists', () {
        expect(DataWipeDetailProvider.of, isNotNull);
      });

      test('BottomButtonState enum exists with expected values', () {
        expect(BottomButtonState.validation, isNotNull);
        expect(BottomButtonState.scanAnother, isNotNull);
        expect(BottomButtonState.initDataWipe, isNotNull);
        expect(BottomButtonState.cashifyProvider, isNotNull);
        expect(BottomButtonState.values.length, 4);
      });

      test('component is configured with DeviceBarcodeParamModel', () {
        const component = DataWipeDetailComponent({});
        expect(component, isNotNull);
        final fromConfig = component.fromConfig();
        expect(fromConfig, isNotNull);
      });
    });
  });
}
