import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/d2c_video/components/d2c_video_home_component.dart';
import 'package:flutter_trc/qc/modules/d2c_video/components/d2c_video_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('D2cVideoHomeComponent', () {
    test('has correct COMP_KEY', () {
      expect(D2cVideoHomeComponent.COMP_KEY, 'QC_d2c_video_home_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = D2cVideoHomeComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = D2cVideoHomeComponent({});
      expect(component, isNotNull);
    });

    test('can be instantiated with key', () {
      const key = Key('d2c_video_home_component_key');
      const component = D2cVideoHomeComponent({}, key: key);
      expect(component.key, equals(key));
    });

    test('COMP_KEY is not empty', () {
      expect(D2cVideoHomeComponent.COMP_KEY.isNotEmpty, isTrue);
    });

    test('COMP_KEY contains QC prefix', () {
      expect(D2cVideoHomeComponent.COMP_KEY.contains('QC'), isTrue);
    });

    test('COMP_KEY contains video identifier', () {
      expect(D2cVideoHomeComponent.COMP_KEY.contains('video'), isTrue);
    });

    test('COMP_KEY contains home identifier', () {
      expect(D2cVideoHomeComponent.COMP_KEY.contains('home'), isTrue);
    });

    test('COMP_KEY contains component identifier', () {
      expect(D2cVideoHomeComponent.COMP_KEY.contains('component'), isTrue);
    });

    test('fromConfig returns a function', () {
      const component = D2cVideoHomeComponent({});
      final configParser = component.fromConfig();
      expect(configParser, isA<Function>());
    });

    test('fromConfig result is consistent across calls', () {
      const component = D2cVideoHomeComponent({});
      final config1 = component.fromConfig();
      final config2 = component.fromConfig();
      expect(config1, equals(config2));
    });

    test('can be instantiated with non-empty config', () {
      const component = D2cVideoHomeComponent({'key': 'value'});
      expect(component, isNotNull);
    });

    test('multiple instances with same config are independent', () {
      const component1 = D2cVideoHomeComponent({});
      const component2 = D2cVideoHomeComponent({});
      expect(component1, isNot(same(component2)));
    });

    test('COMP_KEY is static and accessible', () {
      expect(D2cVideoHomeComponent.COMP_KEY, isA<String>());
    });

    test('COMP_KEY is final and consistent', () {
      final key1 = D2cVideoHomeComponent.COMP_KEY;
      final key2 = D2cVideoHomeComponent.COMP_KEY;
      expect(key1, equals(key2));
    });
  });

  group('D2CVideoComponent', () {
    test('has correct COMP_KEY', () {
      expect(D2CVideoComponent.COMP_KEY, 'QC_d2c_video_component_key');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = D2CVideoComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = D2CVideoComponent({});
      expect(component, isNotNull);
    });

    test('can be instantiated with key', () {
      const key = Key('d2c_video_component_key');
      const component = D2CVideoComponent({}, key: key);
      expect(component.key, equals(key));
    });

    test('COMP_KEY is not empty', () {
      expect(D2CVideoComponent.COMP_KEY.isNotEmpty, isTrue);
    });

    test('COMP_KEY contains QC prefix', () {
      expect(D2CVideoComponent.COMP_KEY.contains('QC'), isTrue);
    });

    test('COMP_KEY contains video identifier', () {
      expect(D2CVideoComponent.COMP_KEY.contains('video'), isTrue);
    });

    test('COMP_KEY contains component identifier', () {
      expect(D2CVideoComponent.COMP_KEY.contains('component'), isTrue);
    });

    test('fromConfig returns a function', () {
      const component = D2CVideoComponent({});
      final configParser = component.fromConfig();
      expect(configParser, isA<Function>());
    });

    test('fromConfig result is consistent across calls', () {
      const component = D2CVideoComponent({});
      final config1 = component.fromConfig();
      final config2 = component.fromConfig();
      expect(config1, equals(config2));
    });

    test('can be instantiated with non-empty config', () {
      const component = D2CVideoComponent({'key': 'value'});
      expect(component, isNotNull);
    });

    test('multiple instances with same config are independent', () {
      const component1 = D2CVideoComponent({});
      const component2 = D2CVideoComponent({});
      expect(component1, isNot(same(component2)));
    });

    test('COMP_KEY is static and accessible', () {
      expect(D2CVideoComponent.COMP_KEY, isA<String>());
    });

    test('COMP_KEY is final and consistent', () {
      final key1 = D2CVideoComponent.COMP_KEY;
      final key2 = D2CVideoComponent.COMP_KEY;
      expect(key1, equals(key2));
    });

    test('COMP_KEY is different from D2cVideoHomeComponent', () {
      expect(D2CVideoComponent.COMP_KEY, isNot(equals(D2cVideoHomeComponent.COMP_KEY)));
    });
  });

  group('D2C Video Components Cross-Comparison', () {
    test('D2CVideoComponent and D2cVideoHomeComponent have different COMP_KEYs', () {
      expect(D2CVideoComponent.COMP_KEY, isNot(equals(D2cVideoHomeComponent.COMP_KEY)));
    });

    test('both components use same config model parser', () {
      const videoComponent = D2CVideoComponent({});
      const homeComponent = D2cVideoHomeComponent({});
      expect(videoComponent.fromConfig(), equals(homeComponent.fromConfig()));
    });

    test('both components can be instantiated independently', () {
      const videoComponent = D2CVideoComponent({});
      const homeComponent = D2cVideoHomeComponent({});
      expect(videoComponent, isNotNull);
      expect(homeComponent, isNotNull);
    });

    test('both COMP_KEYs are unique strings', () {
      final keys = <String>{
        D2CVideoComponent.COMP_KEY,
        D2cVideoHomeComponent.COMP_KEY,
      };
      expect(keys.length, equals(2));
    });

    test('both COMP_KEYs follow naming convention', () {
      expect(D2CVideoComponent.COMP_KEY.startsWith('QC_'), isTrue);
      expect(D2cVideoHomeComponent.COMP_KEY.startsWith('QC_'), isTrue);
    });

    test('both components can have same key assigned', () {
      const key = Key('shared_key');
      const videoComponent = D2CVideoComponent({}, key: key);
      const homeComponent = D2cVideoHomeComponent({}, key: key);
      expect(videoComponent.key, equals(homeComponent.key));
    });
  });

  group('NoneConfigModel integration', () {
    test('NoneConfigModel.fromConfig can parse empty map', () {
      final config = NoneConfigModel.fromConfig({});
      expect(config, isA<NoneConfigModel>());
    });

    test('NoneConfigModel.fromConfig can parse non-empty map', () {
      final config = NoneConfigModel.fromConfig({'key': 'value'});
      expect(config, isA<NoneConfigModel>());
    });

    test('D2CVideoComponent fromConfig returns NoneConfigModel.fromConfig', () {
      const component = D2CVideoComponent({});
      expect(component.fromConfig(), same(NoneConfigModel.fromConfig));
    });

    test('D2cVideoHomeComponent fromConfig returns NoneConfigModel.fromConfig', () {
      const component = D2cVideoHomeComponent({});
      expect(component.fromConfig(), same(NoneConfigModel.fromConfig));
    });
  });
}
