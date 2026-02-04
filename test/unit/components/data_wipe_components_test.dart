import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/data_wipe/components/data_wipe_list_component.dart';
import 'package:flutter_trc/qc/modules/data_wipe/components/data_wipe_detail_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('DataWipeListComponent', () {
    test('has correct COMP_KEY', () {
      expect(DataWipeListComponent.COMP_KEY, 'QC_data_wipe_list_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = DataWipeListComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = DataWipeListComponent({});
      expect(component, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('list_component_key');
      const component = DataWipeListComponent({}, key: testKey);
      expect(component.key, testKey);
    });

    test('can be instantiated with non-empty config', () {
      const component = DataWipeListComponent({'someKey': 'someValue'});
      expect(component, isNotNull);
    });

    test('fromConfig result is a function', () {
      const component = DataWipeListComponent({});
      final fromConfigResult = component.fromConfig();
      expect(fromConfigResult, isA<Function>());
    });

    test('fromConfig can parse empty map', () {
      const component = DataWipeListComponent({});
      final parser = component.fromConfig()!;
      final result = parser({});
      expect(result, isA<NoneConfigModel>());
    });

    test('component jsonConfig is accessible', () {
      const config = {'testKey': 'testValue'};
      const component = DataWipeListComponent(config);
      expect(component.jsonConfig, config);
    });
  });

  group('DataWipeDetailComponent', () {
    test('has correct COMP_KEY', () {
      expect(DataWipeDetailComponent.COMP_KEY, 'QC_data_wipe_detail_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = DataWipeDetailComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = DataWipeDetailComponent({});
      expect(component, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('detail_component_key');
      const component = DataWipeDetailComponent({}, key: testKey);
      expect(component.key, testKey);
    });

    test('can be instantiated with non-empty config', () {
      const component = DataWipeDetailComponent({'someKey': 'someValue'});
      expect(component, isNotNull);
    });

    test('fromConfig result is a function', () {
      const component = DataWipeDetailComponent({});
      final fromConfigResult = component.fromConfig();
      expect(fromConfigResult, isA<Function>());
    });

    test('fromConfig can parse empty map', () {
      const component = DataWipeDetailComponent({});
      final parser = component.fromConfig()!;
      final result = parser({});
      expect(result, isA<NoneConfigModel>());
    });

    test('component jsonConfig is accessible', () {
      const config = {'testKey': 'testValue'};
      const component = DataWipeDetailComponent(config);
      expect(component.jsonConfig, config);
    });
  });

  group('Component constants validation', () {
    test('DataWipeListComponent and DataWipeDetailComponent have different keys', () {
      expect(DataWipeListComponent.COMP_KEY, isNot(DataWipeDetailComponent.COMP_KEY));
    });

    test('DataWipeListComponent key follows naming convention', () {
      expect(DataWipeListComponent.COMP_KEY, startsWith('QC_'));
      expect(DataWipeListComponent.COMP_KEY, contains('data_wipe'));
      expect(DataWipeListComponent.COMP_KEY, endsWith('_component'));
    });

    test('DataWipeDetailComponent key follows naming convention', () {
      expect(DataWipeDetailComponent.COMP_KEY, startsWith('QC_'));
      expect(DataWipeDetailComponent.COMP_KEY, contains('data_wipe'));
      expect(DataWipeDetailComponent.COMP_KEY, endsWith('_component'));
    });
  });

  group('NoneConfigModel integration', () {
    test('both components use same config model', () {
      const listComponent = DataWipeListComponent({});
      const detailComponent = DataWipeDetailComponent({});
      
      expect(listComponent.fromConfig(), detailComponent.fromConfig());
    });

    test('NoneConfigModel.fromConfig handles various inputs', () {
      const component = DataWipeListComponent({});
      final parser = component.fromConfig()!;
      
      // Test with empty map
      expect(parser({}), isA<NoneConfigModel>());
      
      // Test with arbitrary keys
      expect(parser({'foo': 'bar'}), isA<NoneConfigModel>());
      
      // Test with nested objects
      expect(parser({'nested': {'key': 'value'}}), isA<NoneConfigModel>());
    });
  });
}
