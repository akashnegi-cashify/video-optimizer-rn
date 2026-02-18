import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_trc/src/modules/trc_executive/widgets/trc_executive_widget.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/trc_executive_config_model.dart';

void main() {
  group('TrcExecutiveWidget', () {
    test('TrcExecutiveWidget class exists and is a StatelessWidget', () {
      expect(TrcExecutiveWidget, isNotNull);
      const widget = TrcExecutiveWidget();
      expect(widget, isA<StatelessWidget>());
    });

    test('TrcExecutiveWidget can be instantiated with default constructor', () {
      const widget = TrcExecutiveWidget();
      expect(widget, isNotNull);
      expect(widget.key, isNull);
    });

    test('TrcExecutiveWidget can be instantiated with a key', () {
      const key = Key('trc_executive_widget_key');
      const widget = TrcExecutiveWidget(key: key);
      expect(widget.key, equals(key));
    });

    test('TrcExecutiveWidget can be instantiated with null configModel', () {
      const widget = TrcExecutiveWidget(configModel: null);
      expect(widget.configModel, isNull);
    });

    test('TrcExecutiveWidget stores configModel correctly', () {
      final configModel = TrcExecutiveConfigModel(buttonText: 'Custom Button');
      final widget = TrcExecutiveWidget(configModel: configModel);
      expect(widget.configModel, equals(configModel));
      expect(widget.configModel?.buttonText, equals('Custom Button'));
    });

    test('TrcExecutiveWidget can be instantiated with configModel having null buttonText', () {
      final configModel = TrcExecutiveConfigModel(buttonText: null);
      final widget = TrcExecutiveWidget(configModel: configModel);
      expect(widget.configModel, isNotNull);
      expect(widget.configModel?.buttonText, isNull);
    });

    test('TrcExecutiveWidget configModel default value', () {
      const widget = TrcExecutiveWidget();
      expect(widget.configModel, isNull);
    });
  });

  group('TrcExecutiveConfigModel', () {
    test('TrcExecutiveConfigModel can be instantiated with buttonText', () {
      final model = TrcExecutiveConfigModel(buttonText: 'Test Button');
      expect(model.buttonText, equals('Test Button'));
    });

    test('TrcExecutiveConfigModel can be instantiated with null buttonText', () {
      final model = TrcExecutiveConfigModel(buttonText: null);
      expect(model.buttonText, isNull);
    });

    test('TrcExecutiveConfigModel can be instantiated with empty buttonText', () {
      final model = TrcExecutiveConfigModel(buttonText: '');
      expect(model.buttonText, isEmpty);
    });

    test('TrcExecutiveConfigModel fromConfig parses correctly', () {
      final data = {'bt': 'Receive Device'};
      final model = TrcExecutiveConfigModel.fromConfig(data);
      expect(model.buttonText, equals('Receive Device'));
    });

    test('TrcExecutiveConfigModel fromConfig handles missing key', () {
      final data = <String, dynamic>{};
      final model = TrcExecutiveConfigModel.fromConfig(data);
      expect(model.buttonText, isNull);
    });

    test('TrcExecutiveConfigModel fromConfig handles null value', () {
      final data = {'bt': null};
      final model = TrcExecutiveConfigModel.fromConfig(data);
      expect(model.buttonText, isNull);
    });

    test('TrcExecutiveConfigModel fromConfig handles empty string', () {
      final data = {'bt': ''};
      final model = TrcExecutiveConfigModel.fromConfig(data);
      expect(model.buttonText, isEmpty);
    });
  });
}
