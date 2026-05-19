import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/general_header_config.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

/// Tests for App Builder config models.
/// Focus: Testing config parsing and model properties.
void main() {
  group('GeneralHeaderConfig', () {
    group('fromConfig', () {
      test('should parse complete config correctly', () {
        final config = {
          'ht': 'Custom Header Title',
          'sbb': true,
          'slb': false,
          'spb': true,
        };

        final result = GeneralHeaderConfig.fromConfig(config);

        expect(result.headerTitle, 'Custom Header Title');
        expect(result.showBackButton, true);
        expect(result.showLogoutButton, false);
        expect(result.showProfileButton, true);
      });

      test('should handle all boolean true values', () {
        final config = {
          'sbb': true,
          'slb': true,
          'spb': true,
        };

        final result = GeneralHeaderConfig.fromConfig(config);
        expect(result.showBackButton, true);
        expect(result.showLogoutButton, true);
        expect(result.showProfileButton, true);
      });

      test('should handle all boolean false values', () {
        final config = {
          'sbb': false,
          'slb': false,
          'spb': false,
        };

        final result = GeneralHeaderConfig.fromConfig(config);
        expect(result.showBackButton, false);
        expect(result.showLogoutButton, false);
        expect(result.showProfileButton, false);
      });

      test('should handle empty header title', () {
        final config = {
          'ht': '',
        };

        final result = GeneralHeaderConfig.fromConfig(config);

        expect(result.headerTitle, '');
      });

      test('should handle special characters in header title', () {
        final config = {
          'ht': 'Header & Title <Test>',
        };

        final result = GeneralHeaderConfig.fromConfig(config);

        expect(result.headerTitle, 'Header & Title <Test>');
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        final config = GeneralHeaderConfig(
          headerTitle: 'Test Header',
          showBackButton: true,
          showLogoutButton: true,
          showProfileButton: true,
        );

        expect(config.headerTitle, 'Test Header');
        expect(config.showBackButton, true);
        expect(config.showLogoutButton, true);
        expect(config.showProfileButton, true);
      });

      test('should create instance with null parameters', () {
        final config = GeneralHeaderConfig();

        expect(config.headerTitle, isNull);
        expect(config.showBackButton, isNull);
        expect(config.showLogoutButton, isNull);
        expect(config.showProfileButton, isNull);
      });

      test('should create instance with partial parameters', () {
        final config = GeneralHeaderConfig(
          headerTitle: 'Partial',
          showBackButton: false,
        );

        expect(config.headerTitle, 'Partial');
        expect(config.showBackButton, false);
        expect(config.showLogoutButton, isNull);
        expect(config.showProfileButton, isNull);
      });
    });
  });

  group('NoneConfigModel', () {
    group('fromConfig', () {
      test('should create instance from empty config', () {
        final config = <String, dynamic>{};

        final result = NoneConfigModel.fromConfig(config);

        expect(result, isNotNull);
        expect(result, isA<NoneConfigModel>());
      });

      test('should parse config with none key', () {
        final config = {
          'none': 'some value',
        };

        final result = NoneConfigModel.fromConfig(config);

        expect(result, isNotNull);
        expect(result.none, 'some value');
      });

      test('should create instance regardless of unrelated config values', () {
        final config = {
          'key1': 'value1',
          'key2': 123,
          'key3': true,
        };

        final result = NoneConfigModel.fromConfig(config);

        expect(result, isNotNull);
        expect(result, isA<NoneConfigModel>());
      });
    });

    group('constructor', () {
      test('should create instance with none parameter', () {
        final model = NoneConfigModel(none: 'test');

        expect(model.none, 'test');
      });

      test('should create instance without parameter', () {
        final model = NoneConfigModel();

        expect(model.none, isNull);
      });
    });

    group('equality', () {
      test('multiple instances should be equal type', () {
        final model1 = NoneConfigModel();
        final model2 = NoneConfigModel();

        expect(model1.runtimeType, model2.runtimeType);
      });

      test('instances with same none value should have same value', () {
        final model1 = NoneConfigModel(none: 'same');
        final model2 = NoneConfigModel(none: 'same');

        expect(model1.none, model2.none);
      });
    });
  });
}
